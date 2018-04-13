//
//  OrbitingBodyNode.swift
//  Solar System
//
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import SceneKit

let OrbitingAnimationName = "Planet Orbiting Animation"
let SpinningAnimationName = "Planet Spinning Animation"

class OrbitingBodyNode: PhysicsBodyNode {
    
    var bodyInfo: Dictionary<String, Any>?
    
    // Node that draws the orbit ring
    weak var orbitVisualizationNode: SCNNode!
    
    // Node located in the center of the sun rotating the planet
    weak var rotationNode: SCNNode!
    
    // The node's parent in the solar system. This allows us to remove the actual planet from the solar system at any time and add it back in, since the hosting node keeps animating.
    weak var solarSystemHostNode: SCNNode!
    
    var isSpinningAnimationEnabled = false
    var isOrbitingAnimationEnabled = false
    
    func updateAnimationsWithElapsedTime(_ elapsedTime: TimeInterval) {
        
        // Update rotation
        if isSpinningAnimationEnabled {
            var directionMultiplier: SCNNumberType = 1.0
            if let rotationDirectionIsForward = bodyInfo?["rotationDirectionIsForward"] as? Bool {
                if !rotationDirectionIsForward {
                    directionMultiplier = -1.0
                }
            }
            
            let rotationalPeriod = bodyInfo?["rotationalPeriod"] as! Double
            let fullRotation = Double.pi * 2.0
            let elapsedProgress = elapsedTime / rotationalPeriod
            
            let rotationTransform = SCNMatrix4MakeRotation(SCNNumberType(elapsedProgress * fullRotation), 0, directionMultiplier, 0)
            
            transform = SCNMatrix4Mult(rotationTransform, transform)
        }
        
        // Update orbit
        if isOrbitingAnimationEnabled {
            let orbitalPeriod = bodyInfo?["orbitalPeriod"] as! Double
            let scaledOrbitalPeriod = orbitalPeriod / 150.0
            let fullRotation = Double.pi * 2.0
            let elapsedProgress = elapsedTime / scaledOrbitalPeriod
            rotationNode.transform = SCNMatrix4Rotate(rotationNode.transform, SCNNumberType(elapsedProgress * fullRotation), 0, 1, 0)
        }
        
    }
    
    func startOrbitingAnimation() {
        // Add orbiting animation if necessary
        
        if !rotationNode.animationKeys.contains(OrbitingAnimationName) {
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
    
    func startSpinningAnimation() {
        // Add orbiting animation if necessary
        if !rotationNode.animationKeys.contains(SpinningAnimationName) {
            let spinningAnimation = CABasicAnimation(keyPath: "rotation")
            
            let rotationalPeriod = bodyInfo?["rotationalPeriod"] as! Double
            spinningAnimation.duration = rotationalPeriod
            
            var directionMultiplier: Double = 1.0
    
            if let rotationDirectionIsForward = bodyInfo?["rotationDirectionIsForward"] as? Bool {
                if !rotationDirectionIsForward {
                    directionMultiplier = -1.0
                }
            }
            
            spinningAnimation.toValue = NSValue(scnVector4: SCNVector4.init(0, directionMultiplier, 0, Double.pi * 2.0))
            spinningAnimation.repeatCount = .greatestFiniteMagnitude
            addAnimation(spinningAnimation, forKey: OrbitingAnimationName)
        }
    }
    
    func stopSpinningAnimation() {
        rotationNode.removeAnimation(forKey: SpinningAnimationName)
    }
}
