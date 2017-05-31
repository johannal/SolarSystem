//
//  OrbitingBody.swift
//  Solar System
//
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import UIKit

/// A body that orbits a primary body. An #OrbitingBody can also be referred to as the secondary body.
public protocol OrbitingBody: PhysicsBody {
    
    /// Distance of this object from the orbital center point.
    var orbitalRadius: Measurement<UnitLength> { get }
    
    /// The offset from the plane of the orbital system
    var orbitalIncline: Measurement<UnitAngle> { get }
    
    /// Time taken for a this object to make one complete orbit around the center point.
    var orbitalPeriod: SolarDays { get }
    
    /// The time zero epoch for the orbit
    var orbitalEpoch: Date { get }
    
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

public extension OrbitingBody {
    
    var orbitalRadius: Measurement<UnitLength> {
        return Measurement(value: 0, unit: .kilometers)
    }
    
    var orbitalPeriod: SolarDays {
        return 0.0
    }
    
    var orbitalEpoch: Date {
        return Date()
    }
    
    var rotationPeriod: SolarDays {
        return 0.0
    }
    
    var diameter: Measurement<UnitLength> {
        return Measurement(value: 0, unit: .kilometers)
    }
    
    var orbitalIncline: Measurement<UnitAngle> {
        return Measurement(value: 0, unit: .degrees)
    }
    
    func orbit(around center: CGPoint, scale: Double) -> UIBezierPath {
        // Compact form
        /*
        let length = CGFloat(orbitalRadius.converted(to: .meters).value * 2.0)
        let rect = CGRect(
            origin: CGPoint(x: center.x - (length / 2), y: center.y - (length / 2)),
            size: CGSize(width: length, height: length))
        */
        
        // Expressions Extracted
        let length = CGFloat(orbitalRadius.converted(to: .meters).value * 2.0)
        let size: CGSize = CGSize(width: length, height: length)
        let origin: CGPoint = CGPoint(x: center.x - (length / 2), y: center.y - (length / 2))
        let rect = CGRect(
            origin: origin,
            size: size)
        
        return UIBezierPath(ovalIn: rect)
    }
}
