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
    
    let mercury: Planet = Planet(name: "Mercury", color: #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1))
    let venus: Planet = Planet(name: "Venus", color: #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1))
    let earth: Planet = Planet(name: "Earth", color: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    let mars: Planet = Planet(name: "Mars", color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
    let jupiter: Planet = Planet(name: "Jupiter", color: #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1))
    let saturn: Planet = Planet(name: "Saturn", color: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))
    let uranus: Planet = Planet(name: "Uranus", color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
    let neptune: Planet = Planet(name: "Uranus", color: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
    
    public init() {
        
        // DEMO TODO: extract adding of moons to their own method.
        let earthsMoon = Moon(name: "Moon", color: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))
        
        // DEMO TODO: maybe add an item to the array via the structure edit menu?
        planets = [mercury, venus, earth, mars, jupiter, saturn, uranus, neptune]
    }
    
}
