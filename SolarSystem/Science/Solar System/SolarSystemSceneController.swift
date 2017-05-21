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
    @IBOutlet weak var gravityButton: UIButton?
    
    private(set) var planetNodes: [OrbitingBodyNode] = []
    
    // Currently presented planet in details view
    var presentedPlanet: OrbitingBodyNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "The Solar System in 3D"
        
        setupScene()
        
        // Setup tap handling
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(didTapSceneView))
        solarSystemSceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func solarSystemCenterNode() -> SCNNode {
        return solarSystemSceneView.scene!.rootNode.childNode(withName: "SolarSystemCenterNode", recursively: true)!
    }
    
    func cameraNode() -> SCNNode {
        return solarSystemSceneView.scene!.rootNode.childNode(withName: "camera", recursively: true)!
    }
    
    private func setupScene() {
        let centerNode = solarSystemCenterNode()
        
        let planetInfoPath = Bundle.main.path(forResource: "PlanetDetails", ofType: "plist")!
        let planetDictionary = NSDictionary.init(contentsOfFile: planetInfoPath)!
        
        let scaleFactor = 1.0/10000000.0
        
        for (_, value) in planetDictionary {
            if let planetInfo = value as? Dictionary<String, Any> {
                let name = planetInfo["name"] as! String
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
                planetRotationNode.name = name + " Rotation Node"
                planetNode.rotationNode = planetRotationNode
                centerNode.addChildNode(planetRotationNode)
                
                // Planet host node
                let planetHostNode = SCNNode()
                planetHostNode.name = name + " Host Node"
                planetHostNode.position = SCNVector3.init(scaledOrbitalRadius, 0, 0)
                planetRotationNode.addChildNode(planetHostNode)
                planetHostNode.addChildNode(planetNode)
                planetNode.solarSystemHostNode = planetHostNode
                
                // Add orbit
                let planetOrbit = SCNNode()
                planetOrbit.name = name + " Orbit Node"
                planetOrbit.opacity = 0.4
                let orbitSize = CGFloat(scaledOrbitalRadius * 2.0 + scaledDiameter / 2.0)
                planetOrbit.geometry = SCNPlane.init(width: orbitSize, height: orbitSize)
                planetOrbit.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "orbit")
                planetOrbit.geometry?.firstMaterial?.isDoubleSided =  true
                planetOrbit.geometry?.firstMaterial?.diffuse.mipFilter = .linear
                planetOrbit.rotation = SCNVector4.init(1, 0, 0, -Double.pi/2)
                planetOrbit.geometry?.firstMaterial?.lightingModel = .constant // no lighting
                centerNode.addChildNode(planetOrbit)
                planetNode.orbitVisualizationNode = planetOrbit
                
                // Finalize planet
                finalizePlanet(planetNode)
                
                // Start orbiting
                planetNode.startOrbitingAnimation()
                planetNode.startSpinningAnimation()
                
                planetNodes.append(planetNode)
            }
        }
    }
    
    // Do any planet specific things
    func finalizePlanet(_ node: OrbitingBodyNode) {
        if node.name == "Saturn" {
            // Add ring to saturn
            let planetGeometry = node.geometry as! SCNSphere
            
            let ringGeometry = SCNTorus(ringRadius: planetGeometry.radius * 1.6, pipeRadius: planetGeometry.radius / 2.2)
            
            let ringMaterial = SCNMaterial()
            ringMaterial.diffuse.contents = #imageLiteral(resourceName: "2k_saturn_ring+alpha")
            ringMaterial.diffuse.wrapS = .repeat
            ringMaterial.diffuse.wrapT = .repeat
            ringMaterial.isDoubleSided =  true
            ringMaterial.diffuse.mipFilter = .none
            ringMaterial.diffuse.intensity = 0.8
            ringMaterial.diffuse.contentsTransform = SCNMatrix4MakeRotation(Float.pi/180 * -90.0, 0.0, 0.0, 1.0)
            ringMaterial.emission.contents = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            ringMaterial.emission.intensity = 0.2
            ringMaterial.shininess = 0.25
            ringGeometry.firstMaterial = ringMaterial
            
            let ringNode = SCNNode()
            ringNode.transform = SCNMatrix4MakeScale(1.0, 0.05, 1.0)
            ringNode.geometry = ringGeometry
            node.addChildNode(ringNode)
            
            // Give Saturn an angle
            node.solarSystemHostNode.rotation = SCNVector4.init(0.0, 0.0, 1.0, Float.pi/180*10)
        }
    }
    
    
    // Update according to conent types
    
    func updateWithContentType(_ contentType: ContentType) {
        switch contentType {
        case .solarSystem:
            // Put all planets back into the solar system
            for oribitingNode in planetNodes {
                oribitingNode.opacity = 1.0
                oribitingNode.transform = SCNMatrix4Identity
                oribitingNode.solarSystemHostNode.addChildNode(oribitingNode)
            }
            
            // Show the solar system
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 1.0
            solarSystemCenterNode().opacity = 1.0
            SCNTransaction.commit()
            
            presentedPlanet = nil
            gravityButton?.isHidden = false
            
        case .planetDetails:
            // Hide the solar system
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 1.0
            solarSystemCenterNode().opacity = 0.0
            SCNTransaction.commit()
            
            // Present the first planet (or sun?)
            presentPlanet(planetNodes.first!, directionRightToLeft: true)
            
            gravityButton?.isHidden = true
            
        case .planetComparison:
            // TODO
            presentedPlanet = nil
            gravityButton?.isHidden = true
        }
    }
    
    func presentPlanet(_ planet: OrbitingBodyNode, directionRightToLeft: Bool) {
        let previouslyPresentedPlanet = presentedPlanet
        presentedPlanet = planet
        cameraNode().addChildNode(planet)
        
        let rightOutsideTransform = SCNMatrix4MakeTranslation(80, 20, -80)
        
        var planetInitialTransform = SCNMatrix4Identity
        var previouslyPresentedPlanetFinalTransform = SCNMatrix4Identity
        
        if directionRightToLeft {
            planetInitialTransform = rightOutsideTransform
            previouslyPresentedPlanetFinalTransform = SCNMatrix4Invert(rightOutsideTransform)
        }
        else {
            planetInitialTransform = SCNMatrix4Invert(rightOutsideTransform)
            previouslyPresentedPlanetFinalTransform = rightOutsideTransform
        }
        
        // Set initial position
        SCNTransaction.begin()
        SCNTransaction.disableActions = true
        planet.transform = planetInitialTransform//SCNMatrix4MakeTranslation(80, 20, -80)
        planet.opacity = 0.0
        SCNTransaction.commit()
        
        SCNTransaction.begin()
        SCNTransaction.disableActions = false
        SCNTransaction.animationDuration = 2.0
        
        planet.transform = SCNMatrix4MakeTranslation(0, 5, -40)
        
        // Apply scale transform so all planets have the same size
        let planetSphereGeometry = planet.geometry as! SCNSphere
        let desinationSize: Float = 4.2 // FIXME: Calculate a dynamic for the current camera situation
        let equalSizeScaleFactor: Float = desinationSize / Float(planetSphereGeometry.radius)
        planet.transform = SCNMatrix4Scale(planet.transform, equalSizeScaleFactor, equalSizeScaleFactor, equalSizeScaleFactor)
        
        planet.opacity = 1.0
        
        // Animate to final position
        previouslyPresentedPlanet?.transform = previouslyPresentedPlanetFinalTransform//SCNMatrix4MakeTranslation(-80, -20, 80)
        
        SCNTransaction.commit()
    }
    
    func presentNextPlanet() {
        if let currentPresentPlanet = presentedPlanet {
            if let currentIndex = planetNodes.index(of: currentPresentPlanet) {
                if currentIndex < (planetNodes.count-1) {
                    presentPlanet(planetNodes[currentIndex+1], directionRightToLeft: true)
                }
                else {
                    presentPlanet(planetNodes.first!, directionRightToLeft: true)
                }
            }
        }
    }
    
    func presentPreviousPlanet() {
        if let currentPresentPlanet = presentedPlanet {
            if let currentIndex = planetNodes.index(of: currentPresentPlanet) {
                if currentIndex > 1 {
                    presentPlanet(planetNodes[currentIndex-1], directionRightToLeft: false)
                }
                else {
                    presentPlanet(planetNodes.last!, directionRightToLeft: false)
                }
            }
        }
    }
    
    
    // Tap handling
    
    @objc func didTapSceneView(_ sender: UITapGestureRecognizer) {
        let hitTestResults = solarSystemSceneView.hitTest(sender.location(in: solarSystemSceneView), options: nil)
        
        if let hitNode = hitTestResults.first?.node as? PhysicsBodyNode {
            didTapPhysicsBody(hitNode)
        }
    }
    
    func didTapPhysicsBody(_ physicsBody: PhysicsBodyNode) {
        print("Tapped Planet: " + physicsBody.name!)
    }
    
}
