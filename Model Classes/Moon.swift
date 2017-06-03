//
//  Moon.swift
//  Solar System
//
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit

/// Body that orbits a #Planet.
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
    
    /// Creates a new Planet.
    ///
    /// - Parameters:
    ///   - name: name of the planet.
    ///   - color: base color for the planet.
    public init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
    
    // MARK: - Equatable
    
    public static func ==(lhs: Moon, rhs: Moon) -> Bool {
        return lhs.name == rhs.name
    }
}
