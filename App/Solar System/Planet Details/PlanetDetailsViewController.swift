//
//  PlanetSceneDetailsViewController.swift
//  Solar System
//
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

protocol PlanetDetailsVCDelegate: class {
    func planetDetailsNavigationButtonPressed(_ directionForward: Bool)
}

class PlanetSceneDetailsViewController: UIViewController {
    
    weak var delegate: PlanetDetailsVCDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var additionalDetailsLabel: UILabel!
    @IBOutlet weak var topSpacerView: UIView!
    @IBOutlet weak var bottomSpacerView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var experienceGravityButton: UIButton!
    
    var gravitySimulatorVC: GravitySimulatorViewController?
    
    var planetGravity: Double = 5.0
    
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
        experienceGravityButton.alpha = 0.0
        
        UIView.animate(withDuration: 1.0, delay: 1.0, options:.curveEaseInOut, animations: {
            self.nextButton.alpha = 0.3
            self.previousButton.alpha = 0.3
            self.experienceGravityButton.alpha = 1.0
        }, completion: nil)
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
            
            self.planetGravity = (planetInfo["gravity"] as! Double) * -1.0
            
            self.topSpacerView.transform = CGAffineTransform.init(scaleX: 0.1, y: 1.0)
            self.bottomSpacerView.transform = CGAffineTransform.init(scaleX: 0.1, y: 1.0)
            
            UIView.animate(withDuration: 0.7, delay: 0.8, options:.curveEaseInOut, animations: {
                self.titleLabel.alpha = 1.0
            }, completion: { (completed) in
                
                // Animate in separator lines
                UIView.animate(withDuration: 0.7, delay: 0.1, options:.curveEaseInOut, animations: {
                    self.topSpacerView.alpha = 0.3
                    self.bottomSpacerView.alpha = 0.3
                    self.topSpacerView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
                    self.bottomSpacerView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
                }, completion: nil)
                
                // Animate in text
                UIView.animate(withDuration: 0.7, delay: 0.4, options:.curveEaseInOut, animations: {
                    self.descriptionLabel.alpha = 0.8
                }, completion: { (completed) in
                    
                    UIView.animate(withDuration: 0.5) {
                        self.additionalDetailsLabel.alpha = 0.8
                    }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let gravitySimulator = segue.destination as? GravitySimulatorViewController {
            gravitySimulator.planetName = titleLabel.text!
            gravitySimulator.simulatedGravity = planetGravity
        }
    }
    
}
