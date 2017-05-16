//
//  PhysicsBody.swift
//  Science
//
//  Copyright © 2017. All rights reserved.
//

import Foundation

public protocol PhysicsBody {
    
    // TODO come up with things that are functions here rather than properties -- it looks better in the demo.
    
    var mass: Double { get }
    
    var density: Double { get }
    
    var angularVelocity: Double { get }
    
}
