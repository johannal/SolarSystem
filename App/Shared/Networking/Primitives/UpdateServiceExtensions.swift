//
//  UpdateServiceExtensions.swift
//  Solar System Mac
//
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

extension PlanetUpdateService {
    typealias ArrayCompletion<T> = ([T]?, Error?) -> Void

    func refreshPlanets(completion: @escaping ArrayCompletion<SolarSystemPlanet>) {
        var request = MockNetworkRequest(requestURL: "solars.apple.com/planets")
        request.groupingValue = "General"
        performRequest(request: request) { (response: [SolarSystemPlanet]?, error) in
            if let planets = response {
                for planet in planets {
                    self.performSilentRequest(request: planet.newsUpdateRequest) { (_ : [News]?, _) in
                        self.performSilentRequest(request: planet.photoUpdateRequest) { (_ : [Photo]?, _) in
                            self.performSilentRequest(request: planet.newsUpdateRequest) { (_ : [News]?, _) in
                            }
                        }
                    }
                }
            }
            completion(response, error)
        }
    }

    func refreshMoons(for planet: SolarSystemPlanet, completion: @escaping ArrayCompletion<SolarSystemMoon>) {
        performRequest(request: planet.moonRequest) { (response : [SolarSystemMoon]?, error) in
            if let moons = response {
                for moon in moons {
                    self.performSilentRequest(request: moon.photoUpdateRequest) { (_ : [Photo]?, _) in
                        self.performSilentRequest(request: moon.newsUpdateRequest) { (_ : [News]?, _) in
                        }
                    }
                    usleep(10000)
                }
            }
            completion(response, error)
        }
    }

    func performSilentRequest<T>(request: NetworkRequest, completion: @escaping ArrayCompletion<T>) {
        NetworkRequestScheduler.scheduleRequest(request) { (request, resultCode, data) in
            guard let responseData = data else { return }
            NetworkRequestScheduler.scheduleParsingTask(request.identifier, responseData, silent: true) { (parser) in

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
