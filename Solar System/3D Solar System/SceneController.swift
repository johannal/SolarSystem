//
//  SolarSystemController.swift
//  Solar System
//
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import SceneKit

#if os(macOS)
typealias SCNNumberType = CGFloat
typealias Image = NSImage
typealias ImageName = NSImage.Name
typealias UniversalColor = NSColor
typealias UniversalColorName = NSColor.Name
#else
typealias SCNNumberType = Float
typealias Image = UIImage
typealias ImageName = String
typealias UniversalColor = UIColor
typealias UniversalColorName = String
#endif

enum ContentType {
    case solarSystem
    case planetDetails
}

protocol SceneControllerDelegate : class {
    func hideGravityButton(_ hidden: Bool)
}

// Float

class SceneController: NSObject {
    
    weak var solarSystemSceneView: SCNView!
    weak var delegate: SceneControllerDelegate?
    
    // Lighting is on by default
    var enableSceneLighting = true
    
    // Animation coordinator
    var sceneAnimator: SceneAnimator?
    
    private(set) var planetNodes: [OrbitingBodyNode] = []
    
    // Currently presented planet in details view
    var presentedPlanet: OrbitingBodyNode?
    
    init(solarSystemSceneView: SCNView) {
        self.solarSystemSceneView = solarSystemSceneView
    }
    
    func prepareScene() {
        #if targetEnvironment(simulator)
        // Use ambient lighting for simulator
        enableSceneLighting = false
        #endif
        
        // Setup scene
        setupScene()
        
        // Setup scene animator
        sceneAnimator = SceneAnimator(sceneController: self)
                
        // Disable light sources
        if !enableSceneLighting {
            let rootNode = solarSystemSceneView.scene?.rootNode
            rootNode?.childNode(withName: "Omni Light Node", recursively: true)?.isHidden = true
            rootNode?.childNode(withName: "Ambient Light Node", recursively: true)?.isHidden = true
        }
        solarSystemSceneView.autoenablesDefaultLighting = !enableSceneLighting
    }
    
    func solarSystemCenterNode() -> SCNNode {
        return solarSystemSceneView.scene!.rootNode.childNode(withName: "SolarSystemCenterNode", recursively: true)!
    }
    
    func cameraNode() -> SCNNode {
        return solarSystemSceneView.scene!.rootNode.childNode(withName: "Camera", recursively: true)!
    }
    
    private func setupScene() {
        let centerNode = solarSystemCenterNode()
        
        let planetInfoPath = Bundle.main.path(forResource: "PlanetDetails", ofType: "plist")!
        let planetArray = NSArray.init(contentsOfFile: planetInfoPath)!
        
        let scaleFactor = 1.0/10000000.0
        
        for value in planetArray {
            if let planetInfo = value as? Dictionary<String, Any> {
                let name = planetInfo["name"] as! String
                let diameter = planetInfo["diameter"] as! Double
                let diffuseTexture = planetInfo["diffuseTexture"] as! ImageName
                let orbitalRadius = planetInfo["orbitalRadius"] as! Double
                
                
                let scaledDiameter = pow(diameter * scaleFactor * 40000.0, (1.0 / 2.6)) // increase planet size
                let scaledOrbitalRadius = pow(orbitalRadius * scaleFactor, (1.0 / 2.5)) * 6.4 // condense the space
                
                let planetNode = OrbitingBodyNode()
                planetNode.bodyInfo = planetInfo
                planetNode.name = name
                let planetGeometry = SCNSphere.init(radius: CGFloat(scaledDiameter / 2))
                planetGeometry.segmentCount = 60
                
                let diffuseImage = Image(named: diffuseTexture)
                planetGeometry.firstMaterial?.diffuse.contents = diffuseImage
                planetGeometry.firstMaterial?.diffuse.mipFilter = .linear
                
                // Assign normal texture if provided
                if let normalTexture = planetInfo["normalTexture"] as? ImageName {
                    planetNode.geometry?.firstMaterial?.normal.contents = Image(named: normalTexture)
                    planetNode.geometry?.firstMaterial?.normal.mipFilter = .linear
                }
                
                // Assign specular texture if provided
                if let specularTexture = planetInfo["specularTexture"] as? ImageName {
                    planetNode.geometry?.firstMaterial?.normal.contents = Image(named: specularTexture)
                    planetNode.geometry?.firstMaterial?.normal.mipFilter = .linear
                }
                
                // Disable lighting if necessary
                if !enableSceneLighting {
                    planetGeometry.firstMaterial?.lightingModel = .constant // no lighting
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
                
                // Set initial orbit location
                planetNode.positionAtRandomOrbitLocation()
                
                // Start orbiting
                if wantsAnimations() {
                    planetNode.startOrbitingAnimation()
                    planetNode.startSpinningAnimation()
                }
                
                // Finalize planet
                finalizePlanet(planetNode)
                
                planetNodes.append(planetNode)
            }
        }
        
        solarSystemSceneView.scene!.background.contents = #imageLiteral(resourceName: "StarsBackground")
    }
    
    func wantsAnimations() -> Bool {
        var wantsAnimations = true
        if let disableAnimationsEnVar = ProcessInfo.processInfo.environment["DisableAnimations"] {
            let enVar: NSString = disableAnimationsEnVar as NSString
            wantsAnimations = !enVar.boolValue
        }
        return wantsAnimations
    }
    
    // Do any planet specific things
    func finalizePlanet(_ node: OrbitingBodyNode) {
        if node.name == "Saturn" {
            // Add ring to saturn
            let planetGeometry = node.geometry as! SCNSphere
            
            let ringGeometry = SCNTorus(ringRadius: planetGeometry.radius * 1.6, pipeRadius: planetGeometry.radius / 2.2)
            ringGeometry.ringSegmentCount = 60
            
            let ringMaterial = SCNMaterial()
            ringMaterial.diffuse.contents = #imageLiteral(resourceName: "SaturnRing")
            ringMaterial.diffuse.wrapS = .repeat
            ringMaterial.diffuse.wrapT = .repeat
            ringMaterial.isDoubleSided =  true
            ringMaterial.diffuse.mipFilter = .none
            ringMaterial.diffuse.intensity = 0.8
            ringMaterial.diffuse.contentsTransform = SCNMatrix4MakeRotation(SCNNumberType.pi/180 * -90.0, 0.0, 0.0, 1.0)
            ringGeometry.firstMaterial = ringMaterial
            
            let ringNode = SCNNode()
            ringNode.name = "Saturn Ring"
            ringNode.transform = SCNMatrix4MakeScale(1.0, 0.05, 1.0)
            ringNode.geometry = ringGeometry
            ringNode.geometry?.firstMaterial?.lightingModel = .constant // no lighting
            node.addChildNode(ringNode)
            
            // No orbit for Saturn to make bug less obvious
            //node.orbitVisualizationNode.isHidden = true
            //node.isOrbitingAnimationEnabled = false
            
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
            
            let planetDetailsLightNode = solarSystemSceneView.scene?.rootNode.childNode(withName: "Planet Details Light Node", recursively: true)
            planetDetailsLightNode?.light?.intensity = 0.0
            
            let ambientLightNode = solarSystemSceneView.scene?.rootNode.childNode(withName: "Ambient Light Node", recursively: true)
            ambientLightNode?.light?.intensity = 4000.0
            
            SCNTransaction.commit()
            
            presentedPlanet = nil
            delegate?.hideGravityButton(false)
            
        case .planetDetails:
            // Hide the solar system
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 1.0
            solarSystemCenterNode().opacity = 0.0
            
            let planetDetailsLightNode = solarSystemSceneView.scene?.rootNode.childNode(withName: "Planet Details Light Node", recursively: true)
            planetDetailsLightNode?.light?.intensity = 1000.0
            
            let ambientLightNode = solarSystemSceneView.scene?.rootNode.childNode(withName: "Ambient Light Node", recursively: true)
            ambientLightNode?.light?.intensity = 800.0
            
            SCNTransaction.commit()
            
            // Present the first planet (or sun?)
            presentPlanet(planetNodes.first!, directionRightToLeft: true)
            
            delegate?.hideGravityButton(true)
        }
    }
    
    func presentPlanet(_ planet: OrbitingBodyNode, directionRightToLeft: Bool) {
        let previouslyPresentedPlanet = presentedPlanet
        presentedPlanet = planet
        
        // Details view controller
        ///planetDetailsVC?.updateWithPlanetDetails(planet.bodyInfo!) // FIXME!!
        
        // Update Scene
        let planetAnimationNode = SCNNode()
        planetAnimationNode.addChildNode(planet)
        cameraNode().addChildNode(planetAnimationNode)
        
        let rightOutsideTransform = SCNMatrix4MakeTranslation(40, 20, -60)
        
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
        
        // Set initial pos
        SCNTransaction.begin()
        SCNTransaction.disableActions = true
        planetAnimationNode.transform = planetInitialTransform
        planetAnimationNode.opacity = 0.0
        SCNTransaction.commit()
        
        SCNTransaction.begin()
        SCNTransaction.disableActions = false
        SCNTransaction.animationDuration = 2.0
        
        planetAnimationNode.transform = SCNMatrix4MakeTranslation(0, 6.5, -40)
        
        // Apply scale transform so all planets have the same size
        let planetSphereGeometry = planet.geometry as! SCNSphere
        let desinationSize: SCNNumberType = 4.2 // FIXME: Calculate a dynamic for the current camera situation
        let equalSizeScaleFactor: SCNNumberType = desinationSize / SCNNumberType(planetSphereGeometry.radius)
        planetAnimationNode.transform = SCNMatrix4Scale(planetAnimationNode.transform, equalSizeScaleFactor, equalSizeScaleFactor, equalSizeScaleFactor)
        
        planetAnimationNode.opacity = 1.0
        
        // Animate to final pos
        previouslyPresentedPlanet?.parent?.transform = previouslyPresentedPlanetFinalTransform
        
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
    
    func updateAnimatedObjectsWithElapsedTime(_ elapsedTime: TimeInterval) {
        // Let all planetNodes update according to the elapsed time
        for node in planetNodes {
            node.updateAnimationsWithElapsedTime(elapsedTime)
        }
    }
    
    // Tap handling
    @objc func didHitSceneView(atLocation location: CGPoint) {
        let hitTestResults = solarSystemSceneView.hitTest(location, options: nil)
        
        if let hitNode = hitTestResults.first?.node as? PhysicsBodyNode {
            didHitPhysicsBody(hitNode)
        }
    }
    
    func didHitPhysicsBody(_ physicsBody: PhysicsBodyNode) {
        if let physicsBodyName = physicsBody.name {
            print("Tapped Planet: " + physicsBodyName)
            // TODO: Present detailed information about selected planet, moon or star
        }
    }
}
