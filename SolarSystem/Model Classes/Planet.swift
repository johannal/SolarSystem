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
    
    func add(nearbyObject: SmallPlanet) {
        nearbyObjects.append(nearbyObject)
    }
    
    func positionRelativeToStar(date: Date = Date()) -> SolarSystemPoint {
        return parentStar.parentSolarSystem.postion(planet: self, date: date)
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
