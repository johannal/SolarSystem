//
//  PlanetaryBody.swift
//  Science
//
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import UIKit

protocol OrbitingBody: PhysicsBody {
    
    var orbitalRadius: Measurement<UnitLength> { get }
    
    var orbitalPeriod: SolarDays { get }
    
    var rotationPeriod: SolarDays { get }
    
    var diameter: Measurement<UnitLength> { get }
    
    /// Get a path describing the orbit of this body around a given center
    ///
    /// - Parameters:
    ///   - center: The center point of the orbit
    ///   - scale: The scale of the orbit
    /// - Returns: A bezier path representing the orbit
    func orbit(around center: CGPoint, scale: Double) -> UIBezierPath
}
