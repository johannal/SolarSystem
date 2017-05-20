//
//  Sun.swift
//  Science
//
//  Copyright © 2017. All rights reserved.
//

import UIKit

public class Star: PhysicsBody {
    
    public let name: String
    
    public let color: UIColor
    
    public private(set) var planets: [Planet] = []
    
    public private(set) var distantObjects: [SmallPlanet] = []
    
    public init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
    
    func add(distantObject: SmallPlanet) {
        distantObjects.append(distantObject)
    }
    
    // MARK: - PhysicsBody
    
    public func calculateMass() -> Measurement<UnitMass> {
        return Measurement(value: 1.99e27, unit: .metricTons)
    }
    
    public func cacluateDensity() -> Double {
        return 1.408
    }
    
    public func calculateAngularVelocity() -> Measurement<UnitSpeed> {
        return Measurement(value: 1.1e42, unit: .metersPerSecond)
    }
}
