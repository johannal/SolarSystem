//
//  PlanetDataFetcher.swift
//  Solar System Mac
//
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import os.log
//import os.signpost

/// OSLog for logging Solar System Explorer JSON parsing events.
fileprivate let solarSystemLog = OSLog(subsystem: "com.SolarSystemExplorer", 
                                       category: OS_LOG_CATEGORY_POINTS_OF_INTEREST)

/// Provides methods that fetch planet data from 
class PlanetDataFetcher {

    // The URL for our planet data hosted on our sever.
    private let planetDataURL = URL(string: "http://www.solarsystemexplorationapp.com/planetData")! 
    
    func fetchPlanetData(dataHandler: @escaping ([SolarSystemPlanet]?) -> Void) {
        
        // Log that we're queing up a network request for planet data.
        os_log("Requesting planet data", log: solarSystemLog, type: .debug)
        
        // Request the planet data from our server.
        URLSession.shared.dataTask(with: planetDataURL) { (data, response, error) in
            
            // If there was an error fetching the data, log it and return.
            guard error == nil else {
                os_log("Error fetching planet data: %@", log: solarSystemLog, type: .error, String(describing: error))        
                dataHandler(nil)
                return
            }
            
            // If we didn't get any data back, log and return.
            guard let data = data else {
                os_log("No planet data returned", log: solarSystemLog, type: .error)        
                dataHandler(nil)
                return
            }
            
            do {                
                let planets = try self.deserializeAndParseJSON(data)
                dataHandler(planets)
            } catch {
                dataHandler(nil)
                os_log("Error desearlizing JSON: %@", log: solarSystemLog, type: .error, String(describing: error))
            }
        }
    }
    
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
