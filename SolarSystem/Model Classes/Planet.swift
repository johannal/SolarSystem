//
//  Planet.swift
//  Science
//
//  Copyright © 2017. All rights reserved.
//

import UIKit

public class Planet: Hashable {
    
    let name: String
    
    let color: UIColor
    
    private(set) var moons: [Moon] = []
    
    private(set) var nearbyObjects: [SmallPlanet] = []
    
    private(set) var parentStar: Star!
    
    public init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
    
    public func addMoon(_ moon: Moon) {
        moon.parentPlanet = self
        moons.append(moon)
    }
    
    /// Add a nearby object
    ///
    /// - Parameter nearbyObject: The object to add
    func add(nearbyObject: SmallPlanet) {
        nearbyObjects.append(nearbyObject)
    }
    
    /// Remove a nearby object
    ///
    /// - Parameter nearbyObject: The object to remove
    func remove(nearbyObject: SmallPlanet) {
        guard let index = nearbyObjects.index(of: nearbyObject) else {
            return
        }
        nearbyObjects.remove(at: index)
    }
    
    /// Finds the nearest object among the nearby objects
    ///
    /// - Parameter date: The date on which to calculate the location
    /// - Returns: The object, or `nil` if there are no nearby objects
    func findNearestObject(on date: Date = Date()) -> SmallPlanet? {
        let planetPosition = positionRelativeToStar(date: date)
        let objects = nearbyObjects.map { (object: SmallPlanet) -> (Double, SmallPlanet) in
            let objectPosition = object.parentStar.parentSolarSystem.position(of: object, date: date)
            let dx = objectPosition.x - planetPosition.x
            let dy = objectPosition.y - planetPosition.y
            let dz = objectPosition.z - planetPosition.z
            return (sqrt(pow(dx, 2) + pow(dy, 2) + pow(dz, 2)), object)
        }.sorted { (a: (distance: Double, SmallPlanet), b: (distance: Double, SmallPlanet)) -> Bool in
            return a.distance < b.distance
        }
        return objects.first?.1
    }
    
    func positionRelativeToStar(date: Date = Date()) -> SolarSystemPoint {
        return parentStar.parentSolarSystem.position(of: self, date: date)
    }
    
    // MARK: - Hashable
    
    public var hashValue: Int {
        get {
            return name.hashValue
        }
    }
    
    public static func ==(lhs: Planet, rhs: Planet) -> Bool {
        return lhs.name == rhs.name
    }
    
}

extension Planet: OrbitingBody {
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
