//
//  SceneViewController.swift
//  Solar System Mac
//
//  Copyright © 2018 Apple. All rights reserved.
//

import AppKit
import SceneKit

/// An #NSViewController that represents a solar system.
class SceneViewController: NSViewController, SceneControllerDelegate {

    static var wantsAutomaticNewsFeedUpdates: Bool = false
    
    // MARK: - Instance variables

    private let planetsDataSource = SolarSystemPlanetsDataSource()
    private var appearanceManager: SceneViewAppearanceManager?
    private var particleSystemsAnimator: ParticleSystemsAnimator?
    private var sceneController: SceneController?
    private let networkService = PlanetUpdateService()
    private var newsRequestDispatchTimer: DispatchSourceTimer?

    // MARK: - Outlets

    @IBOutlet weak var navigatorCollectionView: NSCollectionView!
    @IBOutlet weak var solarSystemSceneView: SCNView!
    @IBOutlet weak var gravityButton: NSButton?
    @IBOutlet weak var startAnimationButton: NSButton?
    @IBOutlet weak var increaseAnimationSpeedButton: NSButton?
    @IBOutlet weak var decreaseAnimationSpeedButton: NSButton?
    @IBOutlet weak var requestProgressView: NetworkRequestProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup 3D scene view controller
        sceneController = SceneController(solarSystemSceneView: solarSystemSceneView)
        sceneController?.delegate = self
        sceneController?.prepareScene()

        // Setup click gesture recognizer
        let clickGes = NSClickGestureRecognizer(target: self, action: #selector(didClickScene(_:)))
        solarSystemSceneView.addGestureRecognizer(clickGes)

        // Setup data source
        navigatorCollectionView.delegate = planetsDataSource
        navigatorCollectionView.dataSource = planetsDataSource
        
        // Setup appearance manager
//        let appearanceManager = SceneViewAppearanceManager(sceneView: solarSystemSceneView)
//        self.appearanceManager = appearanceManager

        // Setup particle systems manager for scene
//        guard let scene = solarSystemSceneView.scene else { return }
//        let particleAnimator = ParticleSystemsAnimator(scene: scene)
//        self.particleSystemsAnimator = particleAnimator
    }

    /// The color to use for orbit paths.
    /// The color is be subtle, and blends nicely with the background color used for the solar system. This color should only be used for the orbit path itself, and not as a highlight for other objects. Orbits don't generally intersct, but when they do, this color will show up as brighter. To avoid that, the orbit paths should first be composited together into a single bitmap, and then colored. This will avoid the additive color effect. Note that this color can be used for both the active and inactive window state.
    ///
    /// - Note: This color can be used for both the active and inactive window state.
    /// - SeeAlso: #orbitSelectedPathColor, #orbitHaloColor
    /// - Returns: The color to use for orbit paths.
    func orbitPathColor() -> NSColor? {
        return NSColor(red: 0.34, green: 0.532, blue: 0.541, alpha: 0.75)
    }

    /// The color to use for selected orbit paths.
    /// The color is brigther than the orbit color, and is intended to stand out against the background color used for the solar system. This color should only be used for the selected orbit path itself, and not as a selection color for other objects. Orbits don't generally intersct, but when they do, this color will show up as brighter. To avoid that, the orbit paths should first be composited together into a single bitmap, and then colored. This will avoid the additive color effect.
    ///
    /// - Note: This color can be used for both the active and inactive window state.
    /// - SeeAlso: #orbitPathColor, #orbitHaloColor
    /// - Returns: The color to use for selected orbit paths.
    func orbitSelectedPathColor() -> NSColor? {
        return NSColor(red: 0.28, green: 0.49, blue: 0.14, alpha: 0.9)
    }

    /// The color to use for the orbit halo.
    /// The color is intended to be subtle, and add slight differentiation with the background color used for the solar system. This color should only be used for the orbit halo itself, and for halos around other objects. Orbits don't generally intersct, but when they do, halos should blend and add together, unlike the technique used for drawing orbits. The additive effect is desired for halos, whereas it's not desired for standard path drawing.
    ///
    /// - Note: This color can be used for both the active and inactive window state.
    /// - SeeAlso: #orbitPathColor, #orbitSelectedPathColor
    /// - Returns: The color to use for orbit halos.
    func orbitHaloColor() -> NSColor? {
        return NSColor(red: 0.74, green: 0.74, blue: 1.0, alpha: 0.3)
    }

    // MARK: - SceneControllerDelegate

    /// Hides or shows this button that toggles gravity.
    func hideGravityButton(_ hidden: Bool) {
        gravityButton?.isHidden = hidden
    }

    /// Called when the scene is clicked. Passes along the click to the backing SCNView.
    @objc func didClickScene(_ sender: NSClickGestureRecognizer) {
        sceneController?.didHitSceneView(atLocation: sender.location(in: solarSystemSceneView))
    }

    override func viewDidAppear() {
        // Initiate news feed updates if necessary
        if SceneViewController.wantsAutomaticNewsFeedUpdates {
            invokeNewsFeedUpdate(delay: 3.0)
        }
    }

    // MARK: Node Accessors

    /// TODO: Add API Documentation
    func numberOfOrbitingNodes() -> UInt {
        return sceneController?.planetNodes.reduce(0, { (sum, node) -> UInt in
            return node.isOrbitingAnimationEnabled ? sum + 1 : sum
        }) ?? 0
    }
}

extension SceneViewController: PlanetsDetailsListener {
    
    // MARK: - News Feed
    
    func invokeNewsFeedUpdate(delay: Double = 0.0, duartion: Double = 6.0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            SceneViewController.wantsAutomaticNewsFeedUpdates = true
            self.startReceivingNewsFeedUpdates()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duartion) {
                SceneViewController.wantsAutomaticNewsFeedUpdates = false
                self.stopReceivingNewsFeedUpdates()
            }
        }
    }
    
    func startReceivingNewsFeedUpdates() {
        requestProgressView.show(animated: true)
        
        let queue = DispatchQueue(label: "Planet News Timer Queue", attributes: .concurrent)
        newsRequestDispatchTimer?.cancel()
        
        newsRequestDispatchTimer = DispatchSource.makeTimerSource(queue: queue)
        newsRequestDispatchTimer?.schedule(deadline: .now(), repeating: .seconds(5), leeway: .milliseconds(100))
        
        newsRequestDispatchTimer?.setEventHandler { [weak self] in
            self?.refreshPlanetsAndNews()
        }
        
        newsRequestDispatchTimer?.resume()
    }
    
    func stopReceivingNewsFeedUpdates() {
        // Post notification that work is done (this should be posted when the work is actually done)
        NotificationCenter.default.post(name: NetworkRequestCompletedNotification, object: nil)
        
        newsRequestDispatchTimer?.cancel()
        newsRequestDispatchTimer = nil
    }
    
    var isUpdatingNewsFeed: Bool {
        let timerIsActive = newsRequestDispatchTimer != nil
        return timerIsActive
    }

    // MARK: - User Interaction

    /// Performs network request to Solar System REST service which asks about news and planets.

    func refreshPlanetsAndNews() {
        networkService.updatePlanetData(listener: self)
    }

    // MARK: - Network Update Callbacks

    internal func updateWithPlanets(_ planets: [SolarSystemPlanet]?, _ error: Error?) {
        // TODO: refresh UI with updated planet data
    }

    internal func updateWithMoons(_ moons: [SolarSystemMoon]?, forPlanet: SolarSystemPlanet) {
        // TODO: refresh UI with updated moon data
    }
}

