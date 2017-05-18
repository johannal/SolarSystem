//
//  Sun.swift
//  Science
//
//  Copyright © 2017. All rights reserved.
//

import UIKit

public class Star: PhysicsBody {
    
    public let mass: Measurement<UnitMass>
    
    public let density: Double
    
    public let angularVelocity: Double
    
    public let name: String
    
    public let color: UIColor
    
    public private(set) var planets: [Planet] = []
    
    public private(set) var distantObjects: [TransNeptunianObject] = []
    
    public init(name: String, color: UIColor) {
        self.name = name
        self.color = color
        self.mass = Measurement(value: 1.99e27, unit: .metricTons)
        self.density = 1.408
        self.angularVelocity = 1.1e42
    }
    
    func add(distantObject: TransNeptunianObject) {
        distantObjects.append(distantObject)
    }
}
