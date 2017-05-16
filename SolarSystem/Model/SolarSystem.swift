//
//  SolarSystem.swift
//  Science
//
//  Copyright © 2017. All rights reserved.
//

import Foundation

public class SolarSystem {
    
    let sun = Star()
    
    let planets: [Planet]
    
    let earth: Planet
    
    public init() {
        
        // DEMO TODO: maybe add an item to the array via the structure edit menu?
        
//        planets = [Mercury(), Venus(), Earth(), Mars(), Jupiter(), Saturn(), Uranus(), Neptune()]
        
        let earthsMoon = Moon(name: "Moon", color: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))
        earth = Planet(name: "Earth", color: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), moons: [earthsMoon])
        
        planets = [earth]
    }
    
}
