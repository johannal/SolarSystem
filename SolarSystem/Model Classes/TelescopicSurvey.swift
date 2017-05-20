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
    
    /// Add a distant #SmallPlanet
    ///
    /// - Parameter distantObject: The #SmallPlanet to add
    func add(distantObject: SmallPlanet) {
        distantObjects.append(distantObject)
    }
    
    /// Remove a distant #SmallPlanet
    ///
    /// - Parameter distantObject: The #SmallPlanet to remove
    func remove(distantObject: SmallPlanet) {
        guard let index = distantObjects.index(of: distantObject) else {
            return
        }
        distantObjects.remove(at: index)
    }
    
    /// Finds the nearest #SmallPlanet among the distant objects
    ///
    /// - Parameter point: The point from which relative distance is measured
    /// - Returns: The object, or `nil` if there are no distant objects in this survey
    func findNearestDistantObject(to point: SolarSystemPoint) -> SmallPlanet? {
        let objects = distantObjects.map { (object: SmallPlanet) -> (Double, SmallPlanet) in
            let objectPosition = object.parentStar.position(smallPlanet: object, date: self.date)
            let dx = objectPosition.x - point.x
            let dy = objectPosition.y - point.y
            let dz = objectPosition.z - point.z
            return (sqrt(pow(dx, 2) + pow(dy, 2) + pow(dz, 2)), object)
        }.sorted { (a: (distance: Double, SmallPlanet), b: (distance: Double, SmallPlanet)) -> Bool in
            return a.distance < b.distance
        }
        return objects.last?.1
    }
    
    /// Finds the farthest #SmallPlanet among the distant objects
    ///
    /// - Parameter point: The point from which relative distance is measured
    /// - Returns: The object, or `nil` if there are no distant objects in this survey
    func findFarthestDistantObject(to point: SolarSystemPoint) -> SmallPlanet? {
        let objects = distantObjects.map { (object: SmallPlanet) -> (Double, SmallPlanet) in
            let objectPosition = object.parentStar.position(smallPlanet: object, date: date)
            let dx = objectPosition.x - point.x
            let dy = objectPosition.y - point.y
            let dz = objectPosition.z - point.z
            return (sqrt(pow(dx, 2) + pow(dy, 2) + pow(dz, 2)), object)
        }.sorted { (a: (distance: Double, SmallPlanet), b: (distance: Double, SmallPlanet)) -> Bool in
            return a.distance < b.distance
        }
        return objects.first?.1
    }
}
