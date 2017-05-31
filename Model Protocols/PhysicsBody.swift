//
//  PhysicsBody.swift
//  Solar System
//
//  Copyright © 2017. All rights reserved.
//

import Foundation

/// A body that can provide a number of values that affect it's interaction with the physical world.
@objc
public protocol PhysicsBody {
    
    /// Calculates this body's resistance to acceleration (a change in its state of motion) when a net force is applied.
    func calculateMass() -> Measurement<UnitMass>
    
    /// Calculates this body's mass per unit volume.
    func calculateDensity() -> Double
    
    /// Calculates this body's rate of change of angular displacement, and is a vector quantity that specifies the angular speed (rotational speed) of this object and the axis about which this object is rotating.
    func calculateAngularVelocity() -> Measurement<UnitSpeed>
    
}
