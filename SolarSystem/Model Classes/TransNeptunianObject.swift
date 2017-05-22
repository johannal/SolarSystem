//
//  TransNeptunianObject.swift
//  Science
//
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

// DEMO: Rename across multipe files and types
public class TransNeptunianObject: NSObject {
    
    public let name: String
    
    public let shape: Shape
    
    public let parentStar: Star
    
    public enum Shape {
        case spherical
        case oblong
        case irregular
    }
    
    public init(name: String, shape: Shape, parentStar: Star) {
        self.name = name
        self.shape = shape
        self.parentStar = parentStar
    }
    
    func positionRelativeToStar(date: Date = Date()) -> SolarSystemPoint {
        return parentStar.parentSolarSystem.position(of: self, date: date)
    }
}

extension TransNeptunianObject: OrbitingBody {
    public func calculateMass() -> Measurement<UnitMass> {
        return Measurement(value: 0, unit: .kilograms)
    }
    
    public func cacluateDensity() -> Double {
        return 0
    }
    
    public func calculateAngularVelocity() -> Measurement<UnitSpeed> {
        return Measurement(value: 0, unit: .metersPerSecond)
    }
}
