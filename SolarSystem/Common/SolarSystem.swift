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
    
    public init() {
        
        // DEMO TODO: maybe add an item to the array via the structure edit menu?
        
        planets = [Mercury(), Venus(), Earth(), Mars(), Jupiter(), Saturn(), Uranus(), Neptune()]
        
    }
    
}
