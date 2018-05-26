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

/// OSLog for logging Solar System Explorer JSON parsing events.
fileprivate let parsingLog = OSLog(subsystem: "com.SolarSystemExplorer",
                                    category: .pointsOfInterest)

final class PlanetUpdateService {

    func update(listener: PlanetsDetailsListener) {
        
        // Log that we're about to queue up a network request for solars system details.
        os_log(.debug, log: parsingLog, "Requesting Solar System details")

        refreshPlanets { planets, error in
            
            // Update our listener with news and planet statistics
            listener.updateWithPlanets(planets, error)

            // Get details about each planet's satellites
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

                os_signpost(.begin, log: parsingLog, name: "JSONParsing", "Started parsing data of size %d", responseData.count)

                do {
                    let result: [T] = try parser.parse()
                    completion(result, nil)
                } catch {
                    os_log(.error, log: parsingLog, "Parsing error encountered: %@", String(describing: error))
                    completion(nil, error)
                }

                os_signpost(.end, log: parsingLog, name: "JSONParsing", "Finished parsing")

            }
        }
    }

}
