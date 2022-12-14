//
//  GravitySimulatorViewController.swift
//  Solar System
//
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit
import SpriteKit

class GravitySimulatorViewController: UIViewController {
    
    @IBOutlet weak var gravityView: SKView!
    @IBOutlet weak var planetLabel: UILabel!
    
    var simulatedGravity = -7.0
    var planetName = ""
    
    var gravitySimulatorScene: GravitySimulatorScene? {
        get {
            return gravityView.scene as? GravitySimulatorScene
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update the selected planet's name
        planetLabel.text = planetName
        
        gravityView.scene?.scaleMode = .resizeFill
        gravitySimulatorScene?.simulateZeroGravity()
    }
    
    @IBAction func gravityButtonPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        gravitySimulatorScene?.activateGravity(simulatedGravity)
    }
    
    @IBAction func swipeDown(_sender: UISwipeGestureRecognizer) {
        gravitySimulatorScene?.activateGravity(simulatedGravity)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gravityView.scene?.size = CGSize.init(width: 400, height: 1200)
    }
    
}

