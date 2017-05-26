//
//  SolarSystem.swift
//  Science
//
//  Copyright © 2017. All rights reserved.
//

import Foundation

/// A model of a solar system, including a central #Star with orbiting #Planets.
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
    
    // Create arrays for the objects in our SolarSystem.
    let planets: [Planet]
    let distantObjects: [TransNeptunianObject]
    
    public init() {
        
        // create the planets and distant objects.
        planets = [mercury, venus, earth, mars, jupiter, saturn, uranus, venus]
        distantObjects = SolarSystem.loadAndCreateDistantObjects(parentStar: sun)
        
        // add Earth's moon.
        earth.addMoon(Moon(name: "Moon", color: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)))
        
        // add Jupiter's 67 moons 😮!
        if let path = Bundle.main.path(forResource: "MoonsOfJupiter", ofType: "txt") {
            do {
                // grab all the names of Jupiter's moons, which are separated by newlines.
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let moonNames = data.components(separatedBy: .newlines)
                
                // loop over all of Jupiter's moon names.
                for moonName in moonNames {
                    jupiter.addMoon(Moon(name: moonName, color: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)))
                }
            } catch { /* shouldn't end up here. */ }
        }
    }
    
    /// Calculates the coordinate of a given #Planet, at a particular date (which includes time), relative to the Sun.
    ///
    /// - Parameters:
    ///   - planet: the Planet to calculate the coordinate of.
    ///   - date: the date (and time) at which to calcualte the coordinate for.
    /// - Returns: the coordinate, relative to the Sun, of the given planet.
    public func position<Body: OrbitingBody>(of body: Body, date: Date = Date()) -> SolarSystemPoint {
        // Approximation -- for more accuracy see Kepler's equations.
        let period = body.orbitalPeriod
        let radius = body.orbitalRadius.converted(to: .kilometers).value
        let incline = body.orbitalIncline.converted(to: .degrees).value
        let t = date.timeIntervalSince(body.orbitalEpoch) / 86400
        
        let p = (2 * .pi * t) / period.value
        let dx = radius * cos(p)
        let y = radius * sin(p)
        let z = cos(incline) - (dx * sin(incline))
        let x = (z * sin(incline)) + (dx * cos(incline))
        return SolarSystemPoint(x: x, y: y, z: z)
    }
    
    public func distanceBetween(planetA: Planet, planetB: Planet, date: Date = Date()) -> Measurement<UnitLength> {
        
        let planetAPosition = position(of: planetA, date: date)
        let planetBPosition = position(of: planetB, date: date)
        
        let dx = planetAPosition.x - planetBPosition.x
        let dy = planetBPosition.y - planetBPosition.y
        let dz = planetAPosition.z - planetBPosition.z
        let distance = sqrt(pow(dx, 2) + pow(dy, 2) + pow(dz, 2))
        
        return Measurement<UnitLength>(value: distance, unit: .kilometers)
    }
    
    /// Loads and creates the distant objects from the data file.
    ///
    /// - Parameter parentStar: the parent star.
    /// - Returns: an array of distant objects.
    private static func loadAndCreateDistantObjects(parentStar: Star) -> [TransNeptunianObject] {
        var distantObjects: [TransNeptunianObject] = []
        if let path = Bundle.main.path(forResource: "DistantObjects", ofType: "txt") {
            do {
                // grab all the distant objects
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let distantObjectNames = data.components(separatedBy: .newlines)
                let defaultShape = TransNeptunianObject.Shape.spherical
                
                // loop over all of distant object names.
                for distantObjectName in distantObjectNames {
                    distantObjects.append(TransNeptunianObject(name: distantObjectName, shape: defaultShape, parentStar: parentStar))
                }
            } catch {
                // we shouldn't end up here, since we're shipping DistantObjects.txt with our app.
            }
        }
        return distantObjects
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
