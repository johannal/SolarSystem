//
//  PlanetUpdateService.swift
//  Solar System
//
//  Copyright © 2018 Apple. All rights reserved.
//

import os.log
import os.signpost
import Foundation

/// OSLog for logging Solar System Explorer JSON parsing events.
fileprivate let parsingLog = OSLog(subsystem: "com.SolarSystemExplorer", category: .pointsOfInterest)

/// Protocol to get callbacks for planet and moon updates.
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

        // Log that we're queuing up a network request for planet data.
        os_log(.debug, log: parsingLog, "Requesting planet data")

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

    /// Performs a network request and then schedules a parsing task with the result.
    ///
    /// - Parameters:
    ///   - request: The network request to make.
    ///   - completion: The handler to call back once the network request and parsing task have completed.
    func performRequest<T>(request: NetworkRequest, completion: @escaping ArrayCompletion<T>) {

        NetworkRequestScheduler.scheduleRequest(request) { request, resultCode, data in

            guard let responseData = data else {
                completion(nil, UpdateError.requestFailed)
                return
            }

            NetworkRequestScheduler.scheduleParsingTask(request.identifier, responseData) { 
                jsonParser in

                os_signpost(.begin, log: parsingLog, name: "JSONParsing", "Started parsing")

                do {
                    let result: [T] = try jsonParser.parse()
                    completion(result, nil)
                } catch {
                    completion(nil, error)
                }

                os_signpost(.end, log: parsingLog, name: "JSONParsing", "Finished parsing")
            }
        }
    }

}

