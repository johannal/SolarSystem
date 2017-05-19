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

    override func viewDidLoad() {
        super.viewDidLoad()

        gravityView.scene?.scaleMode = .aspectFill
        gravityView.isPaused = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // TODO: Initiate zero gravity animation here
    }
    
    @IBAction func gravityButtonPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        gravityView.isPaused = false
    }

}
