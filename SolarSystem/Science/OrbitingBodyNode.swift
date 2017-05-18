//
//  OrbitingBodyNode.swift
//  Science
//
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import SceneKit

let OrbitingAnimationName = "Planet Orbiting Animation"

class OrbitingBodyNode: PhysicsBodyNode {
    
    var bodyInfo: Dictionary<String, Any>?
    
    // Node that draws the orbit ring
    weak var orbitVisualizationNode: SCNNode!
    
    // Node located in the center of the sun rotating the planet
    weak var rotationNode: SCNNode!
    
    // The node's parent in the solar system. This allows us to remove the actual planet from the solar system at any time and add it back in, since the hosting node keeps animating.
    weak var solarSystemHostNode: SCNNode!
    
    func startOrbitingAnimation() {
        // Add orbiting animation if necessary
        if rotationNode.animation(forKey: OrbitingAnimationName) == nil {
            let orbitingAnimation = CABasicAnimation(keyPath: "rotation")
            
            let orbitalPeriod = bodyInfo?["orbitalPeriod"] as! Double
            orbitingAnimation.duration = orbitalPeriod / 150.0
            orbitingAnimation.toValue = NSValue(scnVector4: SCNVector4.init(0, 1, 0, Double.pi * 2.0))
            orbitingAnimation.repeatCount = .greatestFiniteMagnitude
            rotationNode.addAnimation(orbitingAnimation, forKey: OrbitingAnimationName)
        }
    }
    
    func stopOrbitingAnimation() {
        rotationNode.removeAnimation(forKey: OrbitingAnimationName)
    }

}
