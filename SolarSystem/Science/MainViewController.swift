//
//  MainViewController.swift
//  Science
//
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, SceneHUDDelegate {
    
    @IBOutlet weak var contentContainerView: UIView!
    weak var sceneHUDController: SceneHUDViewController?
    
    weak var planetDetailsVC: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "The Solar System"

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
        self.sceneHUDController = sceneHUDController
        
        // Constraints
        sceneHUDController.view.translatesAutoresizingMaskIntoConstraints = false
        
        let heightConstraint = sceneHUDController.view.heightAnchor.constraint(equalToConstant: 44)
        heightConstraint.priority = UILayoutPriority(749)
        heightConstraint.isActive = true
        
        sceneHUDController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sceneHUDController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sceneHUDController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if planetDetailsVC != nil {
            sceneHUDController?.solarSystemButton?.isHidden = (size.width > size.height)
        }
    }
    
    // Delegate callback
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
        let planetDetailsVC = storyboard!.instantiateViewController(withIdentifier: "planetDetailsVC")
        planetDetailsVC.view.translatesAutoresizingMaskIntoConstraints = false
        addChildViewController(planetDetailsVC)
        contentContainerView.addSubview(planetDetailsVC.view)
        
        // Constraints
        planetDetailsVC.view.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor).isActive = true
        planetDetailsVC.view.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor).isActive = true
        planetDetailsVC.view.topAnchor.constraint(equalTo: contentContainerView.topAnchor).isActive = true
        planetDetailsVC.view.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor).isActive = true
        
        self.planetDetailsVC = planetDetailsVC
    }
    
    func showSolarSystem() {
        planetDetailsVC?.view.removeFromSuperview()
        planetDetailsVC?.removeFromParentViewController()
    }

}
