//
//  PlanetsNewsUpdatesService.swift
//  Solar System
//
//  Copyright © 2018 Apple. All rights reserved.
//

// DEMO TODO: need to actually do some CPU work parsing JSON
// DEMO TODO: toolbar button for network refresh

import os.log
import Foundation

protocol PlanetsDetailsListener {
    func updateWithPlanets(_ news: [Planet]?, _ error: Error?)
}

enum PlanetUpdateServiceError: Error {
    case requestFailed
}

fileprivate let solarLog = OSLog(subsystem: "com.demo.SolarSystem",
                                  category: "JSON Timing")
//                                  category: OS_LOG_CATEGORY_POINTS_OF_INTEREST)

final class PlanetUpdateService<RequestType: NetworkRequest> {
    typealias ArrayCompletionBlock<T> = ([T]?, Error?) -> Void
    typealias ErrorType = PlanetUpdateServiceError

    func update(listener: PlanetsDetailsListener) {
        os_log("Refresh Network Info Triggered", log: solarLog, type: .debug)

        request(.planets) { [weak self] (planets: [Planet]?, error: Error?) in
            listener.updateWithPlanets(planets, error)
            guard let planets = planets else {
                return
            }
            for planet in planets {
                self?.fetchPlanetDetails(for: planet)
                self?.fetchPlanetMoons(for: planet)
            }
        }
    }

    private func performRequest<T>(url: String, completion: @escaping ArrayCompletionBlock<T>) {
        let request = RequestType(requestURL: url)
        NetworkRequestScheduler.scheduleRequest(request) { (request, resultCode, data) in
            guard let responseData = data else {
                completion(nil, ErrorType.requestFailed)
                return
            }

            NetworkRequestScheduler.scheduleParsingTask(request.identifier, responseData) { (parser) in
//                os_signpost_interval_begin(solarLog, request.identifier, "JSONParsing", "Started parsing data of size \(responseData.count)");

                do {
                    let result: [T] = try parser.parse()
                    completion(result, nil)
                } catch {
                    os_log("Parsing error encountered: %@",
                           log: solarLog, type: .error, "\(error)")
                    completion(nil, error)
                }

//                os_signpost_interval_end(solarLog, request.identifier, "JSONParsing", "Finished parsing");
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

    struct Request<Resource> {
        let url: String
        let belongingPlanet: Planet?
        let data: [Resource]


        static var planets: Request<Planet> {
            let planets = [
                Planet(name: "Mercury"),
                Planet(name: "Venus"),
                Planet(name: "Earth"),
                Planet(name: "Mars"),
                Planet(name: "Jupiter"),
                Planet(name: "Saturn"),
                Planet(name: "Uranus"),
                Planet(name: "Neptune")
            ]
            return Request<Planet>(url: "solars.apple.com/planets", belongingPlanet: nil, data: planets)
        }

        static func photo(of planet: Planet) -> Request<Any> {
            return Request<Any>(url: "solars.apple.com/\(planet.name)/photo", belongingPlanet: planet, data: [])
        }

        static func news(about planet: Planet) -> Request<Any> {
            return Request<Any>(url: "solars.apple.com/\(planet.name)/news", belongingPlanet: planet, data: [])
        }

        static func neighbours(of planet: Planet) -> Request<Any> {
            return Request<Any>(url: "solars.apple.com/\(planet.name)/neighbours", belongingPlanet: planet, data: [])
        }

        static func moons(for planet: Planet) -> Request<Moon> {
            var moons: Int = 0
            switch planet.name {
            case "Mercury":
                moons = 0
            case "Venus":
                moons = 0
            case "Earth":
                moons = 1
            case "Mars":
                moons = 2
            case "Jupiter":
                moons = 69
            case "Saturn":
                moons = 62
            case "Uranus":
                moons = 27
            case "Neptune":
                moons = 14
            default:
                break
            }
            let data: [Moon] = (0..<moons).map { val in return Moon(name: "\(val)", planet: planet) }
            return Request<Moon>(url: "solars.apple.com/\(planet.name)/moons", belongingPlanet: planet, data: data)
        }

        static func photo(of moon: Moon) -> Request<Any> {
            return Request<Any>(url: "solars.apple.com/moons/\(moon.name)/image", belongingPlanet: moon.planet, data: [])
        }

        static func news(about moon: Moon) -> Request<Any> {
            return Request<Any>(url: "solars.apple.com/moons/\(moon.name)/news", belongingPlanet: moon.planet, data: [])
        }
    }

    private func request<Resource>(_ request: Request<Resource>, completion: @escaping ArrayCompletionBlock<Resource>) {
        if let planet = request.belongingPlanet {
            os_log("PLANET: %{public}@ URL: %{public}@", log: solarLog, type: .debug, planet.name, request.url)
        }

        performRequest(url: request.url) { (array: [Resource]?, error: Error?) in
            if error == nil {
                completion(request.data, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
