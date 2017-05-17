//
//  SolarSystemController.swift
//  Science
//
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import SceneKit

class SolarSystemController: UIViewController {
    
    @IBOutlet weak var solarSystemSceneView: SCNView!
    
    var sunNode = SCNNode()
    var sunHaloNode = SCNNode()
    var earthNode = SCNNode()
    var earthGroupNode = SCNNode()
    var moonNode = SCNNode()
    
    var sceneView = SCNView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScene()
        
        // Setup HUD
        let sceneHUDController = storyboard!.instantiateViewController(withIdentifier: "sceneHUD")
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
        
        // Setup tap handling
    }
    
    private func setupScene() {
        // Setup scene
        let scene = SCNScene()
        solarSystemSceneView.scene = scene
        
        // Sun
        sunNode.geometry = SCNSphere.init(radius: 2.5)
        
        sunNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "2k_sun")
        sunNode.geometry?.firstMaterial?.diffuse.mipFilter = .linear
        sunNode.geometry?.firstMaterial?.lightingModel = .constant // no lighting
        
        sunNode.position = SCNVector3.init(0, 30, 0)
        scene.rootNode.addChildNode(sunNode)
        
        // Earth-rotation (center of rotation of the Earth around the Sun)
        let earthRotationNode = SCNNode()
        sunNode.addChildNode(earthRotationNode)
        
        // Earth-group (will contain the Earth, and the Moon)
        earthGroupNode.position = SCNVector3.init(15, 0, 0)
        earthRotationNode.addChildNode(earthGroupNode)
        
        // Earth
        earthNode.geometry = SCNSphere.init(radius: 1.5)
        earthNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "2k_earth_daymap")
        earthNode.geometry?.firstMaterial?.diffuse.mipFilter = .linear
        earthNode.geometry?.firstMaterial?.lightingModel = .constant // no lighting
        
        earthNode.geometry?.firstMaterial?.specular.contents = #imageLiteral(resourceName: "2k_earth_specular_map")
        earthNode.geometry?.firstMaterial?.specular.mipFilter = .linear
        
        earthNode.geometry?.firstMaterial?.normal.contents = #imageLiteral(resourceName: "2k_earth_normal_map")
        earthNode.geometry?.firstMaterial?.normal.mipFilter = .linear
        
        earthNode.position = SCNVector3.init(0, 0, 0)
        earthGroupNode.addChildNode(earthNode)
        
        // Moon Rotation
        let moonRotationNode = SCNNode()
        earthGroupNode.addChildNode(moonRotationNode)
        
        // Moon
        moonNode.geometry = SCNSphere.init(radius: 0.75)
        
        moonNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "2k_moon")
        moonNode.geometry?.firstMaterial?.diffuse.mipFilter = .linear
        moonNode.geometry?.firstMaterial?.lightingModel = .constant // no lighting
        
        moonNode.position = SCNVector3.init(5, 0, 0)
        moonRotationNode.addChildNode(moonNode)
        
        // Add a textured plane to represent Earth's orbit
        let earthOrbit = SCNNode()
        earthOrbit.opacity = 0.4;
        earthOrbit.geometry = SCNPlane.init(width: 31, height: 31)
        earthOrbit.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "orbit")
        earthOrbit.geometry?.firstMaterial?.isDoubleSided =  true
        earthOrbit.geometry?.firstMaterial?.diffuse.mipFilter = .linear
        earthOrbit.rotation = SCNVector4.init(1, 0, 0, -Double.pi/2)
        earthOrbit.geometry?.firstMaterial?.lightingModel = .constant // no lighting
        sunNode.addChildNode(earthOrbit)
        
    }
    
}
