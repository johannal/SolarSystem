//
//  Orbit.swift
//  Science
//
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

public class Orbit {
    var parentSolarSystem: SolarSystem
    
    init() {
        fatalError()
    }
    
    init(solarSystem: SolarSystem) {
        parentSolarSystem = solarSystem
    }
    
    func position<Body: OrbitingBody>(of body: Body, date: Date = Date()) -> SolarSystemPoint {
        return parentSolarSystem.position(of: body, date: date)
    }
}
