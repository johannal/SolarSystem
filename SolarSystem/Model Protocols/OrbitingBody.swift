//
//  OrbitingBody.swift
//  Science
//
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import UIKit

/// A body that orbits a primary body. An #OrbitingBody can also be referred to as the secondary body.
protocol OrbitingBody: PhysicsBody {
    
    /// Distance of this object from the orbital center point.
    var orbitalRadius: Measurement<UnitLength> { get }
    
    /// Time taken for a this object to make one complete orbit around the center point.
    var orbitalPeriod: SolarDays { get }
    
    /// Time it takes to complete one revolution around the axis of rotation.
    var rotationPeriod: SolarDays { get }
    
    /// Distance between the two farthest points of this objects largest great circle.
    var diameter: Measurement<UnitLength> { get }
    
    /// Get a path describing the orbit of this body around a given center
    ///
    /// - Parameters:
    ///   - center: The center point of the orbit
    ///   - scale: The scale of the orbit
    /// - Returns: A bezier path representing the orbit
    func orbit(around center: CGPoint, scale: Double) -> UIBezierPath
}
