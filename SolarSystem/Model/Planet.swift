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
    
    let moons: [Moon]
    
    public init(name: String, color: UIColor, moons: [Moon] = []) {
        self.name = name
        self.color = color
        self.moons = moons
        
        for moon in moons {
            moon.parentPlanet = self
        }
    }
}
