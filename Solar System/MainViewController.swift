//
//  MainViewController.swift
//  Solar System
//
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, SceneHUDDelegate, PlanetDetailsVCDelegate {
    
    @IBOutlet weak var contentContainerView: UIView!
    weak var sceneHUDController: SceneHUDViewController?
    
    weak var solarSystemVC: SceneViewController?
    weak var planetDetailsVC: SceneDetailsController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "The Solar System"

        // Initiate solar system controller
        let solarSystemVC = storyboard!.instantiateViewController(withIdentifier: "solarSystemVC") as! SceneViewController
        solarSystemVC.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(solarSystemVC)
        contentContainerView.addSubview(solarSystemVC.view)
        
        // Constraints
        solarSystemVC.view.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor).isActive = true
        solarSystemVC.view.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor).isActive = true
        solarSystemVC.view.topAnchor.constraint(equalTo: contentContainerView.topAnchor).isActive = true
        solarSystemVC.view.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor).isActive = true
        self.solarSystemVC = solarSystemVC
        
        // Initiate HUD controller
        let sceneHUDController = storyboard!.instantiateViewController(withIdentifier: "sceneHUD") as! SceneHUDViewController
        sceneHUDController.delegate = self
        sceneHUDController.view.backgroundColor = UIColor.clear
        addChild(sceneHUDController)
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
    func sceneHUDDidSelectContentType(_ contentType: ContentType) {
        switch contentType {
        case .solarSystem:
            showSolarSystem()
        case .planetDetails:
            showPlanetDetails()
        }
        
        solarSystemVC?.sceneController?.updateWithContentType(contentType)
        sceneHUDController?.updateWithContentType(contentType)
    }
    
    func showPlanetComparison() {
        
    }
    
    func showPlanetDetails() {
        // Initiate solar system controller
        let planetDetailsVC = storyboard!.instantiateViewController(withIdentifier: "planetDetailsVC") as! SceneDetailsController
        planetDetailsVC.delegate = self
        planetDetailsVC.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(planetDetailsVC)
        contentContainerView.addSubview(planetDetailsVC.view)
        
        // Constraints
        planetDetailsVC.view.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor).isActive = true
        planetDetailsVC.view.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor).isActive = true
        planetDetailsVC.view.topAnchor.constraint(equalTo: contentContainerView.topAnchor).isActive = true
        planetDetailsVC.view.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor).isActive = true
        
        self.planetDetailsVC = planetDetailsVC
        solarSystemVC?.planetDetailsVC = planetDetailsVC
    }
    
    func showSolarSystem() {
        planetDetailsVC?.view.removeFromSuperview()
        planetDetailsVC?.removeFromParent()
    }
    
    // Delegate callback
    func planetDetailsNavigationButtonPressed(_ directionForward: Bool) {
        if directionForward {
            solarSystemVC?.sceneController?.presentNextPlanet()
        }
        else {
            solarSystemVC?.sceneController?.presentPreviousPlanet()
        }
    }

}
