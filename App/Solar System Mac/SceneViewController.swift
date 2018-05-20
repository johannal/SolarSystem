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

    // MARK: - Instance variables

    private let planetsDataSource = SolarSystemPlanetsDataSource()
    private var appearanceManager: SceneViewAppearanceManager?
    private var particleSystemsAnimator: ParticleSystemsAnimator?
    private var sceneController: SceneController?
    private let networkService = PlanetsNewsUpdatesService<MockNetworkRequest>()

    // MARK: - Outlets

    @IBOutlet weak var navigatorCollectionView: NSCollectionView!
    @IBOutlet weak var solarSystemSceneView: SCNView!
    @IBOutlet weak var gravityButton: NSButton?
    @IBOutlet weak var startAnimationButton: NSButton?
    @IBOutlet weak var increaseAnimationSpeedButton: NSButton?
    @IBOutlet weak var decreaseAnimationSpeedButton: NSButton?

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

    // TODO: Add more detailed documentation.
    /// Orbit path color.
    func orbitPathColor() -> NSColor? {
        return NSColor(red: 0.34, green: 0.532, blue: 0.541, alpha: 0.75)
    }

    // TODO: Add more detailed documentation.
    /// Orbit selected path color.
    func orbitSelectedPathColor() -> NSColor? {
        return NSColor(red: 0.28, green: 0.49, blue: 0.14, alpha: 0.9)
    }

    // TODO: Add more detailed documentation.
    /// Orbit halo color.
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

    // MARK: Node Accessors

    /// TODO: Add API Documentation
    func numberOfOrbitingNodes() -> UInt {
        return sceneController?.planetNodes.reduce(0, { (sum, node) -> UInt in
            return node.isOrbitingAnimationEnabled ? sum + 1 : sum
        }) ?? 0
    }
}

extension SceneViewController: PlanetsNewsListener {

    // MARK: - User Interaction

    /// Performs network request to Solar System REST service which asks about news and planets.

    func refreshPlanetsAndNews() {
        networkService.update(listener: self)
    }

    // MARK: - Network Update Callbacks

    internal func updateWithPlanets(_ news: [Planet]?, _ error: Error?) {
        // TODO: refresh UI with updated news feed on planets, dwarf planets, and exoplanets
    }

    internal func updateWithNews(_ news: [News]?, _ error: Error?) {
        // TODO: update the new "Today in Space" news view
    }
}
