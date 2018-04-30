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

protocol PlanetsNewsListener {
    func updateWithNews(_ news: [News]?, _ error: Error?)
    func updateWithPlanets(_ news: [Planet]?, _ error: Error?)
}

enum PlanetNewsUpdatesServiceError: Error {
    case requestFailed
}

fileprivate let solarLog = OSLog(subsystem: "com.demo.SolarSystem",
                                  category: "JSON Timing")
//                                  category: OS_LOG_CATEGORY_POINTS_OF_INTEREST)

final class PlanetsNewsUpdatesService<RequestType: NetworkRequest> {
    typealias ArrayCompletionBlock<T> = ([T]?, Error?) -> Void
    typealias ErrorType = PlanetNewsUpdatesServiceError

    func update(listener: PlanetsNewsListener) {
        os_log("Refresh Network Info Triggered", log: solarLog, type: .debug)

        performRequest(url: "solars.apple.com/news") { (news: [News]?, error: Error?) in
            listener.updateWithNews(news, error)
        }

        performRequest(url: "solars.apple.com/planets") { (planets: [Planet]?, error: Error?) in
            listener.updateWithPlanets(planets, error)
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
}
