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
