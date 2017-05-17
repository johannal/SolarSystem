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
    public internal(set) weak var parentPlanet: Planet?
    
    /// An array of sibling moons, if any.
    public var siblings: [Moon] {
        guard let parentPlanet = parentPlanet else { return [] }
        return parentPlanet.moons.filter({ (moon) -> Bool in
            return moon != self
        })
    }
    
    public init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
    
    func orbit(around center: CGPoint, scale: Double) -> UIBezierPath {
        //todo: fill this in, should have some nice expression extractions and/or method extractions
        fatalError()
    }
    
    // MARK: - Equatable
    
    public static func ==(lhs: Moon, rhs: Moon) -> Bool {
        return lhs.name == rhs.name
    }
    
}
