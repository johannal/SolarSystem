//
//  PlanetDetailsViewController.swift
//  Science
//
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit

protocol PlanetDetailsVCDelegate: class {
    func planetDetailsNavigationButtonPressed(_ directionForward: Bool)
}

class PlanetDetailsViewController: UIViewController {
    
    weak var delegate: PlanetDetailsVCDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var additionalDetailsLabel: UILabel!
    
    weak var gravitySimulatorVC: GravitySimulatorViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
    }
    
    @objc override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let deviceOrientationIsLandscape = size.width > size.height
        
        // Update gravity simulator (present or dismiss)
        updateGravitySimulator(deviceOrientationIsLandscape)
    }
    
    @IBAction func showPreviousPlanetButtonPressed(_ sender: UIButton) {
        delegate?.planetDetailsNavigationButtonPressed(false)
    }
    
    @IBAction func showNextPlanetButtonPressed(_ sender: UIButton) {
        delegate?.planetDetailsNavigationButtonPressed(true)
    }
    
    func updateGravitySimulator(_ orientationIsLandscape: Bool) {
        if orientationIsLandscape {
            if gravitySimulatorVC == nil {
                // Add gravity view controller
                let gravitySim = storyboard!.instantiateViewController(withIdentifier: "gravitySimulatorVC") as! GravitySimulatorViewController
                gravitySim.view.translatesAutoresizingMaskIntoConstraints = false
                addChildViewController(gravitySim)
                view.addSubview(gravitySim.view)
                
                // Constraints
                gravitySim.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
                gravitySim.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
                gravitySim.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
                gravitySim.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                
                gravitySimulatorVC = gravitySim
            }
        }
        else {
            // Remove gravity view controller
            gravitySimulatorVC?.view.removeFromSuperview()
            gravitySimulatorVC?.removeFromParentViewController()
        }
    }

}
