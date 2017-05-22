//
//  GravitySimulatorViewController.swift
//  Science
//
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import SpriteKit

class GravitySimulatorViewController: UIViewController {
    
    @IBOutlet weak var gravityView: SKView!
    
    var simulatedGravity = -1.0
    
    var gravitySimulatorScene: GravitySimulatorScene? {
        get {
            return gravityView.scene as? GravitySimulatorScene
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        gravityView.scene?.scaleMode = .aspectFill // DEMO FIX – Use this instead: .resizeFill
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        /// DEMO: Add Log Message Breakpoint: "Gravity Simulator Is Landscape: @deviceOrientationIsLandscape@"
        let deviceOrientationIsLandscape = size.width > size.height
        if deviceOrientationIsLandscape {
            gravitySimulatorScene?.simulateZeroGravity()
        }
    }
    
    @IBAction func gravityButtonPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        gravitySimulatorScene?.activateGravity(simulatedGravity)
    }

}

