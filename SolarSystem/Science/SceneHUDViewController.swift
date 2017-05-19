//
//  SceneHUDViewController.swift
//  Science
//
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit

enum SceneHUDAction {
    case showSolarSystem
    case showPlanetComparison
    case showPlanetDetails
}

protocol SceneHUDDelegate: class {
    func invokedSceneHUDAction(_ action: SceneHUDAction)
}

class SceneHUDViewController: UIViewController {
    
    weak var delegate: SceneHUDDelegate?
    
    @IBOutlet weak var planetDetailsButton: UIButton?
    @IBOutlet weak var planetComparisonButton: UIButton?
    @IBOutlet weak var solarSystemButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        solarSystemButton?.isHidden = true
    }
    
    @IBAction func showPlanetComparisonButtonPressed(_ sender: UIButton) {
        delegate?.invokedSceneHUDAction(.showPlanetComparison)
        
        solarSystemButton?.isHidden = false
        planetComparisonButton?.isHidden = true
        planetDetailsButton?.isHidden = true
    }
    
    @IBAction func showSolarSystemButtonPressed(_ sender: UIButton) {
        delegate?.invokedSceneHUDAction(.showSolarSystem)
        
        solarSystemButton?.isHidden = true
        planetComparisonButton?.isHidden = false
        planetDetailsButton?.isHidden = false
    }
    
    @IBAction func showPlanetDetailsButtonPressed(_ sender: UIButton) {
        delegate?.invokedSceneHUDAction(.showPlanetDetails)
        
        solarSystemButton?.isHidden = false
        planetComparisonButton?.isHidden = true
        planetDetailsButton?.isHidden = true
    }

}
