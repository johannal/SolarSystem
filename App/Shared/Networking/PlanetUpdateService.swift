//
//  PlanetsNewsUpdatesService.swift
//  Solar System
//
//  Copyright © 2018 Apple. All rights reserved.
//

import os.log
import os.signpost
import Foundation

protocol PlanetsDetailsListener {
    func updateWithPlanets(_ planets: [SolarSystemPlanet]?, _ error: Error?)
    func updateWithMoons(_ moons: [SolarSystemMoon]?, forPlanet: SolarSystemPlanet)
}

/// Helper class to handle requesting data from the network, and parsing that data. 
final class PlanetUpdateService {

    /// Fetches updated planet data.
    ///
    /// - Parameter listener: The listener to call back with the updated data.
    func updatePlanetData(listener: PlanetsDetailsListener) {

        refreshPlanets { planets, error in
            
            // Update our listener with news and planet statistics.
            listener.updateWithPlanets(planets, error)

            // Get details about each planet's satellites.
            for planet in planets! {
                self.refreshMoons(for: planet) { moons, _ in
                    listener.updateWithMoons(moons, forPlanet: planet)
                }
            }
        }
    }

    func performRequest<T>(request: NetworkRequest, completion: @escaping ArrayCompletion<T>) {
        
        NetworkRequestScheduler.scheduleRequest(request) { (request, resultCode, data) in
            guard let responseData = data else {
                completion(nil, UpdateError.requestFailed)
                return
            }

            NetworkRequestScheduler.scheduleParsingTask(request.identifier, responseData) { (parser) in

                do {
                    let result: [T] = try parser.parse()
                    completion(result, nil)
                } catch {
                    completion(nil, error)
                }

            }
        }
    }

}

