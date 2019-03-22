//
//  SceneHUDViewController.swift
//  Solar System
//
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

protocol SceneHUDDelegate: class {
    func sceneHUDDidSelectContentType(_ contentType: ContentType)
}

class SceneHUDViewController: UIViewController {
    
    weak var delegate: SceneHUDDelegate?
    
    @IBOutlet weak var planetDetailsButton: UIButton?
    @IBOutlet weak var planetListButton: UIButton?
    @IBOutlet weak var solarSystemButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup for solar system content
        updateWithContentType(.solarSystem)
    }
    
    @IBAction func showSolarSystemButtonPressed(_ sender: UIButton) {
        delegate?.sceneHUDDidSelectContentType(.solarSystem)
    }
    
    @IBAction func showPlanetDetailsButtonPressed(_ sender: UIButton) {
        delegate?.sceneHUDDidSelectContentType(.planetDetails)
    }
    
    func updateWithContentType(_ contentType: ContentType) {
        switch contentType {
        case .solarSystem:
            solarSystemButton?.isHidden = true
            planetListButton?.isHidden = false
            planetDetailsButton?.isHidden = false
        case .planetDetails:
            solarSystemButton?.isHidden = false
            planetListButton?.isHidden = true
            planetDetailsButton?.isHidden = true            
        }
    }
    
}
