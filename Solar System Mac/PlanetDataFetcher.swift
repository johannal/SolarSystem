//
//  PlanetDataFetcher.swift
//  Solar System Mac
//
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import os.log
import os.signpost

/// Provides methods that fetch and parse planet data, and then hands back  #SolarSystemPlanet model objects from that data.
final class PlanetDataFetcher {

    // The URL for our planet data hosted on our sever.
    private let planetDataURL = URL(string: "http://www.solarsystemexplorationapp.com/planetData")! 
    
    func fetchPlanetData(dataHandler: @escaping ([SolarSystemPlanet]?) -> Void) {
        
        // Request the planet data from our server.
        SolarSystemURLSession.shared.dataTask(with: planetDataURL) { (data, response, error) in
            
            // If there was an error fetching the data, log it and return.
            guard error == nil else {
                dataHandler(nil)
                return
            }
            
            // If we didn't get any data back, log and return.
            guard let data = data else {
                dataHandler(nil)
                return
            }
            
            do {
                let planets = try self.deserializeAndParseJSON(data)
                dataHandler(planets)
            } catch {
                dataHandler(nil)
            }
            
        }
    }
    
    /// Deserializes the given data as JSON, and then creates an array of #SolarSystemPlanets from that data. If the data isn't doesn't have "planets", then nil will be returned.
    ///
    /// - Parameter data: The data to deserialize as JSON.
    /// - Returns: An array of #SolarSystemPlanets or nil if the JSON doesn't have a "planets" key.
    /// - Throws: If deserialization fails.
    private func deserializeAndParseJSON(_ data: Data) throws -> [SolarSystemPlanet]? {
        
        // Deserialize the JSON.
        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return nil
        }
        
        // Extract out the planets.
        guard let planetsJSON = json["planets"] as? [[String: Any]] else {
            return nil
        }
        
        // Create the array of planets that we'll build up.
        var planets: [SolarSystemPlanet] = []
        
        // Loop over the JSON and create planets for each bit of data.
        for case let planetJSON in planetsJSON {
            if let planet = SolarSystemPlanet(json: planetJSON) {
                planets.append(planet)
            }
        }
        
        return planets
    }
} 

extension SolarSystemPlanet {
    init?(json: [String: Any]?) {
        self.init(name: "planet")
    }
}

fileprivate typealias SolarSystemURLSession = URLSession
