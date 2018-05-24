//
//  PlanetDataFetcher.swift
//  Solar System Mac
//
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import os.log
import os.signpost

/// OSLog for logging Solar System Explorer JSON parsing events.
fileprivate let parsingLog = OSLog(subsystem: "com.SolarSystemExplorer", category: .pointsOfInterest)

private let jsonDecoder = JSONDecoder()

/// Provides methods that fetch and parse planet data, and then hands back  #SolarSystemPlanet model objects from that data.
final class PlanetDataFetcher {

    // The URL for our planet data hosted on our sever.
    private let planetDataURL = URL(string: "http://www.solarsystemexplorationapp.com/planetData")! 
    
    func fetchPlanetData(dataHandler: @escaping ([SolarSystemPlanet]?) -> Void) {
        
        // Log that we're queing up a network request for planet data.
        os_log("Requesting planet data", log: parsingLog, type: .debug)
        
        // Request the planet data from our server.
        SolarSystemURLSession.shared.dataTask(with: planetDataURL) { (data, response, error) in
            
            // If there was an error fetching the data, log it and return.
            guard error == nil else {
                os_log("Error fetching planet data: %@", log: parsingLog, type: .error, String(describing: error))        
                dataHandler(nil)
                return
            }
            
            // If we didn't get any data back, log and return.
            guard let data = data else {
                os_log("No planet data returned", log: parsingLog, type: .error)        
                dataHandler(nil)
                return
            }
            
            do {
                let planets = try self.deserializeAndParseJSON(from: data)
                dataHandler(planets)
            } catch {
                dataHandler(nil)
                os_log("Error desearlizing JSON: %@", log: parsingLog, type: .error, String(describing: error))
            }
            
        }
    }
    
    /// Deserializes the given data as JSON, and then creates an array of #SolarSystemPlanets from that data. If the data isn't doesn't have "planets", then nil will be returned.
    ///
    /// - Parameter data: The data to deserialize as JSON.
    /// - Returns: An array of #SolarSystemPlanets or nil if the JSON doesn't have a "planets" key.
    /// - Throws: If deserialization fails.
    private func deserializeAndParseJSON(from data: Data) throws -> [SolarSystemPlanet]? {
        return try jsonDecoder.decode([SolarSystemPlanet].self, from: data)
    }
    
} 

extension SolarSystemPlanet {
    init?(json: [String: Any]?) {
        self.init(name: "planet")
    }
}

fileprivate typealias SolarSystemURLSession = URLSession
fileprivate let requestID: UInt = 0
