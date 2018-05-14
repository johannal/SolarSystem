//
//  SolarSystemSceneViewController.swift
//  Solar System Mac
//
//  Copyright © 2018 Apple. All rights reserved.
//

import AppKit
import SceneKit

/// An #NSViewController that represents a solar system.
class SolarSystemSceneViewController: NSViewController, SolarSystemSceneControllerDelegate {
    
    let navigator = Navigator()
    let inspector = Inspector()
    
    @IBOutlet weak var navigatorCollectionView: NSCollectionView!
    @IBOutlet weak var solarSystemSceneView: SCNView!
    @IBOutlet weak var gravityButton: NSButton?
    @IBOutlet weak var startAnimationButton: NSButton?
    @IBOutlet weak var increaseAnimationSpeedButton: NSButton?
    @IBOutlet weak var decreaseAnimationSpeedButton: NSButton?
    
    var sceneController: SolarSystemSceneController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup 3D scene view controller
        sceneController = SolarSystemSceneController(solarSystemSceneView: solarSystemSceneView)
        sceneController?.delegate = self
        sceneController?.prepareScene()
        
        // Setup click gesture recognizer
        let clickGes = NSClickGestureRecognizer(target: self, action: #selector(didClickSceneView(_:)))
        solarSystemSceneView.addGestureRecognizer(clickGes)
        
        // Setup navigator controller
        navigator.collectionView = navigatorCollectionView
    }
    
    /// Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
    /// Duis id interdum elit. Suspendisse id risus massa. In eu sollicitudin enim, non fringilla nunc. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam consectetur, nulla ac hendrerit pharetra, eros orci consectetur sapien, a consequat nisi elit vel ex. Pellentesque ultrices felis et urna scelerisque efficitur. Vivamus scelerisque mattis tellus, non porta libero interdum et. Curabitur varius sagittis enim id dignissim.
    ///
    /// - Returns: The color to use to draw an #OrbitingBodyNode's orbit path.
    func orbitPathColor() -> NSColor? {
        return NSColor(red: 0.34, green: 0.532, blue: 0.541, alpha: 0.75)
    }
    
    /// Nam faucibus commodo leo sit amet molestie. 
    /// Ut sed suscipit lacus, in fermentum lectus. Donec varius consequat pellentesque. Maecenas ullamcorper nisi sed dolor pellentesque, id sagittis turpis suscipit. Nam hendrerit vestibulum tincidunt. Etiam a magna gravida, iaculis quam ut, lacinia justo. Phasellus ex tortor, dapibus in finibus eu, dictum at libero. Pellentesque et dignissim velit, id rutrum erat. Nam molestie justo neque, ut posuere tortor malesuada non. Quisque sit amet facilisis enim. Morbi elementum lacus ac massa ultricies, et convallis velit dignissim. Ut rhoncus justo non nibh placerat pharetra. Vestibulum volutpat varius tellus non auctor. Suspendisse tempus neque quis porttitor tristique. Duis tristique tortor in quam ornare eleifend. In sed risus dolor.
    ///
    /// - Returns: The color to use to draw a selected #OrbitingBodyNode's orbit path.
    func orbitSelectedPathColor() -> NSColor? {
        return NSColor(red: 0.28, green: 0.49, blue: 0.14, alpha: 0.9)
    }
    
    /// Aliquam ut lorem euismod, suscipit mauris ut, semper tortor. 
    /// Duis ullamcorper est ante, eget elementum tortor interdum et. Quisque pellentesque commodo libero, at vestibulum arcu. Morbi ullamcorper lorem ut neque blandit pretium. Nullam lectus justo, sagittis nec egestas ut, rutrum vel lacus. Duis et metus nec nisl egestas dignissim. Aliquam a accumsan nunc, a tincidunt augue. Donec sollicitudin aliquet ornare. Aliquam volutpat at sem quis bibendum. Vestibulum volutpat justo vel nisl volutpat aliquam. Sed consequat, lacus lacinia fermentum dapibus, mi turpis hendrerit odio, ut pharetra enim lorem eget eros. Sed vitae odio tristique nibh dictum laoreet. Quisque scelerisque, quam at volutpat auctor, mi ante mollis massa, sit amet gravida odio mauris non dolor. Sed finibus elit et dolor bibendum dignissim.
    ///
    /// - Returns: The color to use to draw a halo under an #OrbitingBodyNode's orbit path.
    func orbitHaloColor() -> NSColor? {
        return NSColor(red: 0.74, green: 0.74, blue: 1.0, alpha: 0.3)
    }
    
    // MARK: - SolarSystemSceneControllerDelegate
    
    /// Hides or shows this button that toggles gravity.
    func hideGravityButton(_ hidden: Bool) {
        gravityButton?.isHidden = hidden
    }
    
    /// Called when the scene is clicked. Passes along the click to the backing SCNView.
    @objc func didClickSceneView(_ sender: NSClickGestureRecognizer) {
        sceneController?.didHitSceneView(atLocation: sender.location(in: solarSystemSceneView))
    }

    // MARK: Node Accessors

    /// TODO: Add API Documentation
    func numberOfOrbitingNodes() -> UInt {
        guard let orbitingNodes = sceneController?.planetNodes else { return 0 }
        
        var numberOfOrbitingNodes: UInt = 0
        for node in orbitingNodes {
            if (node.isOrbitingAnimationEnabled) {
                numberOfOrbitingNodes += 1
            }
        }
        
        return numberOfOrbitingNodes
    }
}
