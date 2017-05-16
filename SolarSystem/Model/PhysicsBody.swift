//
//  PhysicsBody.swift
//  Science
//
//  Copyright © 2017. All rights reserved.
//

import Foundation

public protocol PhysicsBody {
    
    var mass: Double { get }
    
    var density: Double { get }
    
    var angularVelocity: Double { get }
    
}
