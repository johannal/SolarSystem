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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    @IBAction func gravityButtonPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }

}
