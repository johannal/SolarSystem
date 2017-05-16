//
//  PlanetaryBody.swift
//  Science
//
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

protocol OrbitingBody: PhysicsBody {
    
    var orbitalRadius: Double { get }
    
    var orbitalPeriod: SolarDays { get }
    
    var rotationPeriod: SolarDays { get }
    
    var diameter: Measurement<UnitLength> { get }
}
