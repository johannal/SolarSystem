//
//  SolarSystem.swift
//  Science
//
//  Copyright © 2017. All rights reserved.
//

import Foundation

/// The solar system we call home.
public class SolarSystem {
    
    // Create the sun.
    let sun = Star(name: "Sun", color: #colorLiteral(red: 1, green: 0.5549516082, blue: 0.005077361129, alpha: 1))
    
    // Create the planets.
    let mercury: Planet = Planet(name: "Mercury", color: #colorLiteral(red: 0.6472379565, green: 0.6025107503, blue: 0.5466887951, alpha: 1))
    let venus: Planet = Planet(name: "Venus", color: #colorLiteral(red: 0.3882164955, green: 0.3436552286, blue: 0.2652897239, alpha: 1))
    let earth: Planet = Planet(name: "Earth", color: #colorLiteral(red: 0.3583836854, green: 0.4615976214, blue: 0.5621570349, alpha: 1))
    let mars: Planet = Planet(name: "Mars", color: #colorLiteral(red: 0.8524389267, green: 0.6224156618, blue: 0.4205289483, alpha: 1))
    let jupiter: Planet = Planet(name: "Jupiter", color: #colorLiteral(red: 0.398963064, green: 0.4041557312, blue: 0.36931777, alpha: 1))
    let saturn: Planet = Planet(name: "Saturn", color: #colorLiteral(red: 0.8856078386, green: 0.7523123622, blue: 0.5600671172, alpha: 1))
    let uranus: Planet = Planet(name: "Uranus", color: #colorLiteral(red: 0.5745319724, green: 0.7137514353, blue: 0.7544075847, alpha: 1))
    let neptune: Planet = Planet(name: "Neptune", color: #colorLiteral(red: 0.3400839567, green: 0.5141240954, blue: 0.6517244577, alpha: 1))
    
    // ** DEMO BLOCKER: rdar://problem/31501493 **
    
    // Create arrays for the objects in our SolarSystem.
    let planets: [Planet]
    let distantObjects: [TransNeptunianObject]
    
    // Create a dictionary to map planets to their orbits.
    let planetsToOrbits: [Planet: Orbit]
    
    public init() {
        
        // ** DEMO POLISH: rdar://problem/32247713
        // ** DEMO BLOCKER: rdar://problem/32039874 **
        
        // create the planets array with an ordered list of our planets.
        planets = [mercury, venus, earth, mars, jupiter, saturn, uranus, venus]
        
        // create a mapping of planets to orbits.
        planetsToOrbits = [mercury: mercuryOrbit, venus: venusOrbit, earth: earthOrbit, mars: marsOrbit, jupiter: jupiterOrbit, saturn: saturnOrbit, uranus: uranusOrbit]
        
        // add Earth's moon.
        earth.addMoon(Moon(name: "Moon", color: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)))
        
        // add Mars' moons.
        mars.addMoon(Moon(name: "Deimos", color: #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)))
        mars.addMoon(Moon(name: "Phobos", color: #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)))
        
        // ** DEMO BLOCKER: rdar://problem/32225277 **
        // DEMO TODO: extract adding of jupiters moons to its own method.
        
        // add Jupiter's 67 moons 😮!
        if let path = Bundle.main.path(forResource: "MoonsOfJupiter", ofType: "txt") {
            do {
                // grab all the names of Jupiter's moons, which are separated by newlines.
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let moonNames = data.components(separatedBy: .newlines)
                
                // loop over all of Jupiter's moon names.
                for moonName in moonNames {
                    mars.addMoon(Moon(name: moonName, color: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)))
                }
            } catch {
                // we shouldn't end up here, since we're shipping MoonsOfJupiter.txt with our app.
            }
        }
        
        distantObjects = []
        
    }
    
    // Orbits
    let mercuryOrbit = Orbit()
    let venusOrbit = Orbit()
    let earthOrbit = Orbit()
    let marsOrbit = Orbit()
    let jupiterOrbit = Orbit()
    let saturnOrbit = Orbit()
    let uranusOrbit = Orbit()
    let neptuneOrbit = Orbit()
    
}
