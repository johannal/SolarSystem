//
//  Planet.swift
//  Science
//
//  Copyright © 2017. All rights reserved.
//

import UIKit

public class Planet {
    
    let name: String
    
    let color: UIColor
    
    private(set) var moons: [Moon] = []
    
    public init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
    
    public func addMoon(_ moon: Moon) {
        moon.parentPlanet = self
        moons.append(moon)
    }
}
