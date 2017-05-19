//
//  MainViewController.swift
//  Science
//
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, SceneHUDDelegate {
    
    @IBOutlet weak var contentContainerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initiate solar system controller
        let solarSystemVC = storyboard!.instantiateViewController(withIdentifier: "solarSystemVC")
        solarSystemVC.view.translatesAutoresizingMaskIntoConstraints = false
        addChildViewController(solarSystemVC)
        contentContainerView.addSubview(solarSystemVC.view)
        
        // Constraints
        solarSystemVC.view.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor).isActive = true
        solarSystemVC.view.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor).isActive = true
        solarSystemVC.view.topAnchor.constraint(equalTo: contentContainerView.topAnchor).isActive = true
        solarSystemVC.view.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor).isActive = true
        
        
        // Initiate HUD controller
        let sceneHUDController = storyboard!.instantiateViewController(withIdentifier: "sceneHUD") as! SceneHUDViewController
        sceneHUDController.delegate = self
        sceneHUDController.view.backgroundColor = UIColor.clear
        addChildViewController(sceneHUDController)
        view.addSubview(sceneHUDController.view)
        
        // Constraints
        sceneHUDController.view.translatesAutoresizingMaskIntoConstraints = false
        
        let heightConstraint = sceneHUDController.view.heightAnchor.constraint(equalToConstant: 44)
        heightConstraint.priority = UILayoutPriority(749)
        heightConstraint.isActive = true
        
        sceneHUDController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sceneHUDController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sceneHUDController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
    }
    
    func invokedSceneHUDAction(_ action: SceneHUDAction) {
        switch action {
        case .showPlanetComparison:
            showPlanetComparison()
        case .showPlanetDetails:
            showPlanetDetails()
        case .showSolarSystem:
            showSolarSystem()
        }
    }
    
    func showPlanetComparison() {
        
    }
    
    func showPlanetDetails() {
        // Initiate solar system controller
        let solarSystemVC = storyboard!.instantiateViewController(withIdentifier: "planetDetailsVC")
        solarSystemVC.view.translatesAutoresizingMaskIntoConstraints = false
        addChildViewController(solarSystemVC)
        contentContainerView.addSubview(solarSystemVC.view)
        
        // Constraints
        solarSystemVC.view.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor).isActive = true
        solarSystemVC.view.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor).isActive = true
        solarSystemVC.view.topAnchor.constraint(equalTo: contentContainerView.topAnchor).isActive = true
        solarSystemVC.view.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor).isActive = true
    }
    
    func showSolarSystem() {
        
    }

}
