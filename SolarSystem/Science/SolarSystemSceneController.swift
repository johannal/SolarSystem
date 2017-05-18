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
    private(set) var planetNodes: [OrbitingBodyNode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScene()
        
        // Setup HUD
        let sceneHUDController = storyboard!.instantiateViewController(withIdentifier: "sceneHUD")
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
        
        // Setup tap handling
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(didTapSceneView))
        solarSystemSceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setupScene() {
        let centerNode = solarSystemSceneView.scene?.rootNode.childNode(withName: "SolarSystemCenterNode", recursively: true)!
        
        let planetInfoPath = Bundle.main.path(forResource: "PlanetDetails", ofType: "plist")!
        let planetDictionary = NSDictionary.init(contentsOfFile: planetInfoPath)!
        
        let scaleFactor = 1.0/10000000.0
        
        for (_, value) in planetDictionary {
            if let planetInfo = value as? Dictionary<String, Any> {
                let name = planetInfo["name"] as? String
                let diameter = planetInfo["diameter"] as! Double
                let diffuseTexture = planetInfo["diffuseTexture"] as! String
                let orbitalRadius = planetInfo["orbitalRadius"] as! Double
                
                
                let scaledDiameter = pow(diameter * scaleFactor * 40000.0, (1.0 / 2.6)) // increase planet size
                let scaledOrbitalRadius = pow(orbitalRadius * scaleFactor, (1.0 / 2.5)) * 6.4 // condense the space
                
                let planetNode = OrbitingBodyNode()
                planetNode.bodyInfo = planetInfo
                planetNode.name = name
                let planetGeometry = SCNSphere.init(radius: CGFloat(scaledDiameter / 2))
                
                let diffuseImage = UIImage(named: diffuseTexture)
                planetGeometry.firstMaterial?.diffuse.contents = diffuseImage
                planetGeometry.firstMaterial?.diffuse.mipFilter = .linear
                planetGeometry.firstMaterial?.lightingModel = .constant // no lighting
                
                // Assign normal texture if provided
                if let normalTexture = planetInfo["normalTexture"] as? String {
                    planetNode.geometry?.firstMaterial?.normal.contents = UIImage(named: normalTexture)
                    planetNode.geometry?.firstMaterial?.normal.mipFilter = .linear
                }
                
                // Assign specular texture if provided
                if let specularTexture = planetInfo["specularTexture"] as? String {
                    planetNode.geometry?.firstMaterial?.normal.contents = UIImage(named: specularTexture)
                    planetNode.geometry?.firstMaterial?.normal.mipFilter = .linear
                }
                
                planetNode.geometry = planetGeometry
                
                // Rotation node of the planet
                let planetRotationNode = SCNNode()
                planetNode.rotationNode = planetRotationNode
                centerNode?.addChildNode(planetRotationNode)
                
                // Planet host node
                let planetHostNode = SCNNode()
                planetHostNode.position = SCNVector3.init(scaledOrbitalRadius, 0, 0)
                planetRotationNode.addChildNode(planetHostNode)
                planetHostNode.addChildNode(planetNode)
                
                // Add orbit
                let planetOrbit = SCNNode()
                planetOrbit.opacity = 0.4
                let orbitSize = CGFloat(scaledOrbitalRadius * 2.0 + scaledDiameter / 2.0)
                planetOrbit.geometry = SCNPlane.init(width: orbitSize, height: orbitSize)
                planetOrbit.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "orbit")
                planetOrbit.geometry?.firstMaterial?.isDoubleSided =  true
                planetOrbit.geometry?.firstMaterial?.diffuse.mipFilter = .linear
                planetOrbit.rotation = SCNVector4.init(1, 0, 0, -Double.pi/2)
                planetOrbit.geometry?.firstMaterial?.lightingModel = .constant // no lighting
                centerNode?.addChildNode(planetOrbit)
                planetNode.orbitVisualizationNode = planetOrbit
                
                // Start orbiting
                planetNode.startOrbitingAnimation()
                
                planetNodes.append(planetNode)
            }
        }
    }
    
    @objc func didTapSceneView(_ sender: UITapGestureRecognizer) {
        let results = solarSystemSceneView.hitTest(sender.location(in: solarSystemSceneView), options: nil)
        
        if let hitNode = results.first?.node as? PhysicsBodyNode {
            didTapPhysicsBody(hitNode)
        }
    }
    
    func didTapPhysicsBody(_ physicsBody: PhysicsBodyNode) {
        print("Tapped Planet: " + physicsBody.name!)
    }
    
}
