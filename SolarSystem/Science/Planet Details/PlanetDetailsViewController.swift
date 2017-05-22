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
    @IBOutlet weak var topSpacerView: UIView!
    @IBOutlet weak var bottomSpacerView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    
    var gravitySimulatorVC: GravitySimulatorViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        
        titleLabel.alpha = 0.0
        descriptionLabel.alpha = 0.0
        additionalDetailsLabel.alpha = 0.0
        topSpacerView.alpha = 0.0
        bottomSpacerView.alpha = 0.0
        nextButton.alpha = 0.0
        previousButton.alpha = 0.0
        
        UIView.animate(withDuration: 1.0, delay: 1.0, options:.curveEaseInOut, animations: {
            self.nextButton.alpha = 0.3
            self.previousButton.alpha = 0.3
        }, completion: nil)
        
        setupGravitySimulator()
    }
    
    func updateWithPlanetDetails(_ planetInfo: Dictionary<String, Any>) {
        UIView.animate(withDuration: 0.4, animations: {
            self.titleLabel.alpha = 0.0
            self.descriptionLabel.alpha = 0.0
            self.additionalDetailsLabel.alpha = 0.0
            self.topSpacerView.alpha = 0.0
            self.bottomSpacerView.alpha = 0.0
            
        }) { (completed) in
            let planetName = planetInfo["name"] as! String
            self.titleLabel.text = planetName.uppercased()
            
            let description = planetInfo["description"] as! String
            self.descriptionLabel.text = description
            
            let additionalDetails = planetInfo["additionalDetails"] as! String
            self.additionalDetailsLabel.text = additionalDetails
            
            self.topSpacerView.transform = CGAffineTransform.init(scaleX: 0.1, y: 1.0)
            self.bottomSpacerView.transform = CGAffineTransform.init(scaleX: 0.1, y: 1.0)
            
            UIView.animate(withDuration: 0.8, delay: 1.0, options:.curveEaseInOut, animations: {
                self.titleLabel.alpha = 1.0
            }, completion: { (completed) in
                
                UIView.animate(withDuration: 0.7, delay: 0.3, options:.curveEaseInOut, animations: {
                    self.topSpacerView.alpha = 0.3
                    self.bottomSpacerView.alpha = 0.3
                    self.topSpacerView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
                    self.bottomSpacerView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
                }, completion: { (completed) in
                    
                    UIView.animate(withDuration: 0.7, delay: 0.3, options:.curveEaseInOut, animations: {
                        self.descriptionLabel.alpha = 0.8
                    }, completion: { (completed) in
                        
                        UIView.animate(withDuration: 0.7) {
                            self.additionalDetailsLabel.alpha = 0.8
                        }
                    })
                })
            })
        }
    }
    
    @IBAction func showPreviousPlanetButtonPressed(_ sender: Any) {
        delegate?.planetDetailsNavigationButtonPressed(false)
    }
    
    @IBAction func showNextPlanetButtonPressed(_ sender: Any) {
        delegate?.planetDetailsNavigationButtonPressed(true)
    }
    
    func setupGravitySimulator() {
        // Add gravity view controller
        let gravitySim = storyboard!.instantiateViewController(withIdentifier: "gravitySimulatorVC") as! GravitySimulatorViewController
        gravitySim.view.translatesAutoresizingMaskIntoConstraints = false
        gravitySim.view.alpha = 0.0
        addChildViewController(gravitySim) /// DEMO FIX – addChildViewController
        addChildViewController(gravitySim)
        view.addSubview(gravitySim.view)
        
        // Constraints
        gravitySim.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        gravitySim.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        gravitySim.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        gravitySim.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        gravitySimulatorVC = gravitySim
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Show of hide gravity simulator
        let deviceOrientationIsLandscape = size.width > size.height
        if deviceOrientationIsLandscape {
            UIView.animate(withDuration: 0.3, animations: {
                self.gravitySimulatorVC?.view.alpha = 1.0
            })
        }
        else {
            UIView.animate(withDuration: 0.3, animations: {
                self.gravitySimulatorVC?.view.alpha = 0.0
            })
        }
    }
    
}
