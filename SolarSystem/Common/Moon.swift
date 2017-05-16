//
//  Moon.swift
//  Science
//
//  Copyright © 2017. All rights reserved.
//

import UIKit

// DEMO: implement "PhysicsBody" here -- get issue with fix-it
public class Moon: Equatable {
    
    /// The name of this moon.
    public let name: String
    
    /// The primary color of this moon.
    public let color: UIColor
    
    /// The planet that this moon orbits.
    public let parentPlanet: Planet
    
    /// An array of sibling moons, if any.
    public var siblings: [Moon] {
        return parentPlanet.moons.filter({ (moon) -> Bool in
            return moon != self
        })
    }
    
    public init(name: String, color: UIColor, parentPlanet: Planet) {
        self.name = name
        self.color = color
        self.parentPlanet = parentPlanet
    }
    
    // DEMO TODO: add an extract-expression here.
    
    // DEMO TODO: add an extract-method here.
    
    // MARK: - Equatable
    
    public static func ==(lhs: Moon, rhs: Moon) -> Bool {
        return lhs.name == rhs.name
    }
    
}
