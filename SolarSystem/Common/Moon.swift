//
//  Moon.swift
//  Science
//
//  Created by Ken Orr on 5/15/17.
//  Copyright © 2017 Debugger UI. All rights reserved.
//

import UIKit

// DEMO: implement "PhysicsBody" here -- get issue with fix-it
public class Moon {
    
    public let name: String
    
    public let color: UIColor
    
    public let parentPlanet: Planet
    
    public private(set) var siblings: [Moon] = []
    
    public init(name: String, color: UIColor, parentPlanet: Planet) {
        self.name = name
        self.color = color
        self.parentPlanet = parentPlanet
    }
    
}
