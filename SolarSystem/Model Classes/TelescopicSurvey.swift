//
//  TelescopicSurvey.swift
//  Science
//
//  Created by Russ Bishop on 5/20/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

class TelescopicSurvey {
    var date: Date = Date()
    
    var stars: [Star] = []
    
    var moons: [Moon] = []
    
    var distantObjects: [SmallPlanet] = []
    
    /// Add a distant object.
    ///
    /// - Parameter distantObject: The planet to add
    func add(distantObject: SmallPlanet) {
        distantObjects.append(distantObject)
    }
    
    /// Remove a distant object.
    ///
    /// - Parameter distantObject: The planet to remove
    func remove(distantObject: SmallPlanet) {
        guard let index = distantObjects.index(of: distantObject) else {
            return
        }
        distantObjects.remove(at: index)
    }
    
    /// Finds the nearest object among the distant objects
    ///
    /// - Parameter point: The point from which relative distance is measured
    /// - Returns: The object, or `nil` if there are no distant objects in this survey
    func findNearestDistantObject(to point: SolarSystemPoint) -> SmallPlanet? {
        let objects = distantObjects.map { (object: SmallPlanet) -> (Double, SmallPlanet) in
            let solarSystem: SolarSystem = object.parentStar.parentSolarSystem
            let objectPosition = solarSystem.position(of: object, date: self.date)
            let delta = objectPosition - point
            
            return (sqrt(pow(delta.x, 2) + pow(delta.y, 2) + pow(delta.z, 2)), object)
        }.sorted { (a: (distance: Double, SmallPlanet), b: (distance: Double, SmallPlanet)) -> Bool in
            return a.distance < b.distance
        }
        return objects.last?.1
    }
    
    /// Finds the farthest object among the distant objects
    ///
    /// - Parameter point: The point from which relative distance is measured
    /// - Returns: The object, or `nil` if there are no distant objects in this survey
    func findFarthestDistantObject(to point: SolarSystemPoint) -> SmallPlanet? {
        let objects = distantObjects.map { (object: SmallPlanet) -> (Double, SmallPlanet) in
            let solarSystem: SolarSystem = object.parentStar.parentSolarSystem
            let objectPosition = solarSystem.position(of: object, date: date)
            let delta = objectPosition - point
            
            return (sqrt(pow(delta.x, 2) + pow(delta.y, 2) + pow(delta.z, 2)), object)
        }.sorted { (a: (distance: Double, SmallPlanet), b: (distance: Double, SmallPlanet)) -> Bool in
            return a.distance < b.distance
        }
        return objects.first?.1
    }
}

