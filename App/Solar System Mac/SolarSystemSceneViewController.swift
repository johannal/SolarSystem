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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "The Solar System in 3D"
        
        sceneController = SolarSystemSceneController(solarSystemSceneView: solarSystemSceneView)
        sceneController?.delegate = self
        sceneController?.prepareScene()
        
        let clickGes = NSClickGestureRecognizer(target: self, action: #selector(didClickSceneView(_:)))
        solarSystemSceneView.addGestureRecognizer(clickGes)
    }
    
    func hideGravityButton(_ hidden: Bool) {
        
    }
    
    // Tap handling
    @objc func didClickSceneView(_ sender: NSClickGestureRecognizer) {
        sceneController?.didHitSceneView(atLocation: sender.location(in: solarSystemSceneView))
    }
    
}
