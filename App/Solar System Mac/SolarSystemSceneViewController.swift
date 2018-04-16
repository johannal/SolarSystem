//
//  SolarSystemSceneViewController.swift
//  Solar System Mac
//
//  Created by Sebastian Fischer on 15.03.18.
//  Copyright © 2018 Apple. All rights reserved.
//

import AppKit
import SceneKit

class SolarSystemSceneViewController: NSViewController, SolarSystemSceneControllerDelegate {

    @IBOutlet weak var solarSystemSceneView: SCNView!
    var sceneController: SolarSystemSceneController?
    
    @IBOutlet weak var gravityButton: NSButton?
    @IBOutlet weak var startAnimationButton: NSButton?
    @IBOutlet weak var increaseAnimationSpeedButton: NSButton?
    @IBOutlet weak var decreaseAnimationSpeedButton: NSButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup 3D scene view controller
        sceneController = SolarSystemSceneController(solarSystemSceneView: solarSystemSceneView)
        sceneController?.delegate = self
        sceneController?.prepareScene()
        
        // Setup click gesture recognizer
        let clickGes = NSClickGestureRecognizer(target: self, action: #selector(didClickSceneView(_:)))
        solarSystemSceneView.addGestureRecognizer(clickGes)
    }
    
    // MARK: - Solar System UI
    
    func orbitPathColor() -> NSColor {
        return NSColor(red: 0.34, green: 0.532, blue: 0.541, alpha: 0.75)
    }
    
    func orbitSelectedPathColor() -> NSColor {
        return NSColor(red: 0.28, green: 0.49, blue: 0.14, alpha: 0.9)
    }
    
    func orbitHaloColor() -> NSColor {
        return NSColor(red: 0.74, green: 0.74, blue: 1.0, alpha: 0.3)
    }
    
    // MARK: - SolarSystemSceneControllerDelegate
    
    func hideGravityButton(_ hidden: Bool) {
        gravityButton?.isHidden = hidden
    }
    
    @objc func didClickSceneView(_ sender: NSClickGestureRecognizer) {
        sceneController?.didHitSceneView(atLocation: sender.location(in: solarSystemSceneView))
    }
}
