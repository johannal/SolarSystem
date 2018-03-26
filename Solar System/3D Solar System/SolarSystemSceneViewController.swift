//
//  SolarSystemSceneViewController.swift
//  Solar System
//
//  Created by Sebastian Fischer on 15.03.18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class SolarSystemSceneViewController: UIViewController, SolarSystemSceneControllerDelegate {
    
    @IBOutlet weak var solarSystemSceneView: SCNView!
    @IBOutlet weak var gravityButton: UIButton?

    var sceneController: SolarSystemSceneController?
    
    // Details view controller if presented
    weak var planetDetailsVC: PlanetDetailsViewController?

    var timer: CADisplayLink!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "The Solar System in 3D"
        
        sceneController = SolarSystemSceneController(solarSystemSceneView: solarSystemSceneView)
        sceneController?.delegate = self
        sceneController?.prepareScene()
        
        // Setup display link
        timer = CADisplayLink(target: self, selector: #selector(tick))
        timer?.add(to: .main, forMode: .defaultRunLoopMode)
        
        // Setup tap handling
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(didTapSceneView))
        solarSystemSceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer.isPaused = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.isPaused = true
    }
    
    // Display Link callback
    @objc func tick() {
        sceneController?.tick(timestamp: timer.timestamp)
    }
    
    // Tap handling
    @objc func didTapSceneView(_ sender: UITapGestureRecognizer) {
        let hitLocation = sender.location(in: solarSystemSceneView)
        sceneController?.didHitSceneView(atLocation: hitLocation)
    }
    
    // MARK: - SolarSystemSceneControllerDelegate

    func hideGravityButton(_ hidden: Bool) {
        gravityButton?.isHidden = hidden
    }



}
