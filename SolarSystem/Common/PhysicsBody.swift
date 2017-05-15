//
//  PhysicsBody.swift
//  Science
//
//  Created by Ken Orr on 5/15/17.
//  Copyright © 2017 Debugger UI. All rights reserved.
//

import Foundation

public protocol PhysicsBody {
    
    var mass: Double { get }
    
    var density: Double { get }
    
    var angularVelocity: Double { get }
    
}
