//
//  PlanetsNewsUpdatesService.swift
//  Solar System
//
//  Copyright © 2018 Apple. All rights reserved.
//

import os.log
import Foundation

protocol PlanetsDetailsListener {
    func updateWithPlanets(_ news: [Planet]?, _ error: Error?)
}

enum PlanetUpdateServiceError: Error {
    case requestFailed
}

/// OSLog for logging Solar System Explorer JSON parsing events.
fileprivate let solarSystemLog = OSLog(subsystem: "com.SolarSystemExplorer", 
                                       category: "JSON Fetching and Parsing")

final class PlanetUpdateService<RequestType: NetworkRequest> {
    
    typealias ArrayCompletionBlock<T> = ([T]?, Error?) -> Void
    typealias ErrorType = PlanetUpdateServiceError

    func update(listener: PlanetsDetailsListener) {
        
        // log that we're about to queue up a network request for solars system details.
        os_log("Request Solar System details", log: solarSystemLog, type: .debug)

        request(.planets) { [weak self] (planets: [Planet]?, error: Error?) in
            listener.updateWithPlanets(planets, error)
            
            guard let planets = planets else { return }
            
            // for each plannet, get it's details and moons.
            for planet in planets {
                self?.fetchPlanetDetails(for: planet)
                self?.fetchPlanetMoons(for: planet)
            }
        }
    }

    private func performRequest<T>(request: Request<T>, completion: @escaping ArrayCompletionBlock<T>) {
        let request = RequestType(request: request)
        NetworkRequestScheduler.scheduleRequest(request) { (request, resultCode, data) in
            guard let responseData = data else {
                completion(nil, ErrorType.requestFailed)
                return
            }

            NetworkRequestScheduler.scheduleParsingTask(request.identifier, responseData) { (parser) in

                do {
                    let result: [T] = try parser.parse()
                    completion(result, nil)
                } catch {
                    os_log("Parsing error encountered: %@",
                           log: solarSystemLog, type: .error, "\(error)")
                    completion(nil, error)
                }

            }
        }
    }














    
    private func fetchPlanetDetails(for planet: Planet) {
        request(Request<Any>.photo(of: planet)) { (_, _) in }
        request(Request<Any>.neighbours(of: planet)) { (_, _) in }
        request(Request<Any>.news(about: planet)) { (_, _) in }
    }

    private func fetchPlanetMoons(for planet: Planet) {
        request(Request<Moon>.moons(for: planet)) { [weak self] (moons: [Moon]?, error: Error?) in
            if let moons = moons {
                for moon in moons {
                    self?.request(Request<Any>.photo(of: moon)) { (_, _) in }
                    self?.request(Request<Any>.news(about: moon)) { (_, _) in }
                }
            }
        }
    }

    private func request<Resource>(_ request: Request<Resource>, completion: @escaping ArrayCompletionBlock<Resource>) {
        if let planet = request.belongingPlanet {
            os_log("PLANET: %{public}@ URL: %{public}@", log: solarSystemLog, type: .debug, planet.name, request.url)
        }

        performRequest(request: request) { (array: [Resource]?, error: Error?) in
            if error == nil {
                completion(request.data, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
