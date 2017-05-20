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
    
    public private(set) var parentSolarSystem: SolarSystem!
    
    public init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
    
    /// Add a #SmallPlanet as a distant object
    /// related to this #Star
    ///
    /// - Parameter distantObject: The distant object to add
    func add(distantObject: SmallPlanet) {
        distantObjects.append(distantObject)
    }
    
    func position(planet: Planet, date: Date = Date()) -> SolarSystemPoint {
        return parentSolarSystem.position(planet: planet, date: date)
    }
    
    func position(smallPlanet: SmallPlanet, date: Date = Date()) -> SolarSystemPoint {
        return parentSolarSystem.position(smallPlanet: smallPlanet, date: date)
    }
    
    func positionsOfPlanets(date: Date = Date()) -> [SolarSystemPoint] {
        var positions: [SolarSystemPoint] = []
        for planet in planets {
            positions.append(parentSolarSystem.position(planet: planet, date: date))
        }
        return positions
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
