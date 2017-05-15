//
//  Moon.swift
//  Science
//
//  Copyright © 2017. All rights reserved.
//

import UIKit

// DEMO: implement "PhysicsBody" here -- get issue with fix-it
public class Moon {
    
    /// The name of this moon.
    public let name: String
    
    /// The primary color of this moon.
    public let color: UIColor
    
    /// The planet that this moon orbits.
    public let parentPlanet: Planet
    
    /// An array of sibling moons, if any.
    public private(set) var siblings: [Moon] = []
    
    public init(name: String, color: UIColor, parentPlanet: Planet) {
        self.name = name
        self.color = color
        self.parentPlanet = parentPlanet
    }
    
}
