//
//  NetworkRequestScheduler.swift
//  Solar System Mac
//
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import os.log

fileprivate let legacyLog = OSLog(subsystem: "com.SolarSystemExplorer",
                                   category: "JSON Fetching and Parsing")

final class NetworkRequestScheduler {
    private static let callbackQueue = DispatchQueue(label: "com.demo.SolarSystem.networkCallbacks")
    private static let schedulingQueue = DispatchQueue(label: "com.demo.SolarSystem.networkScheduling")
    private static let outstandingTrackingQueue = DispatchQueue(label: "com.demo.SolarSystem.atomicRequestTracking")
    private static var scheduledRequests = 0 // Protected by the outstandingTrackingQueue

    private static let parsingQueue = DispatchQueue.main
    private static let simultaneousRequestSem = DispatchSemaphore(value: 150)

    private static let solarNetworkingLog = OSLog(subsystem: "com.demo.SolarSystem", category: "Networking")

    private class func _requestDidStart() {
        outstandingTrackingQueue.sync {
            scheduledRequests += 1
        }
    }

    private class func _requestDidFinish() {
        outstandingTrackingQueue.sync {
            scheduledRequests -= 1
            if scheduledRequests == 0 {
                os_signpost(.event, log: solarNetworkingLog, name: "NetworkRequest", "Request queue complete")
            }
        }
    }

    class func scheduleParsingTask(_ identifier: UInt, _ data: Data, silent: Bool = false, workItem: @escaping (RequestParser)->Void) {
        let parser = plannedResponses[identifier] ?? MockRequestParser(data: data)
        parsingQueue.async {
            if (silent) {
                workItem(parser)
            } else {
                let signpostID = OSSignpostID(log: solarNetworkingLog)
                os_signpost(.begin, log: solarNetworkingLog, name: "ResponseParsing", signpostID: signpostID, "Parsing started SIZE:%ld", parser.bytes)
                let t1 = Date.timeIntervalSinceReferenceDate
                os_log("Started parsing data of size %lu", parser.bytes)
                workItem(parser)
                let t2 = Date.timeIntervalSinceReferenceDate
                os_log("Finished parsing (took %3.2f seconds)", t2-t1)
                os_signpost(.end, log: solarNetworkingLog, name: "ResponseParsing", signpostID: signpostID, "Parsing finished")
            }
            usleep(1000 * 5)
        }
    }

    private class func shouldGenerateDuplicateRequest() -> Bool {
        let seed = arc4random()
        return seed % 100 == 0
    }

    class func scheduleRequest(_ request: NetworkRequest, handler: @escaping (NetworkRequest, Int, Data?)->Void) {
        os_log(.debug, log: legacyLog, "PLANET: %{public}@ URL: %{public}@", request.groupingValue, request.requestURL)
        if let cannedParser = fakeParserForRequest(request) {
            plannedResponses[request.identifier] = cannedParser
        }
        _requestDidStart()
        schedulingQueue.async {
            simultaneousRequestSem.wait()
            let signpostID = OSSignpostID(log: solarNetworkingLog)
            os_signpost(.begin, log: solarNetworkingLog, name: "NetworkRequest", signpostID: signpostID, "Request started URL:%{public}@,TYPE:%{public}@,CATEGORY:%{public}@", request.requestURL, "GET", request.groupingValue)
            request.perform(queue: callbackQueue) { (completedRequest, resultCode, data) in
                simultaneousRequestSem.signal()
                os_signpost(.end, log: solarNetworkingLog, name: "NetworkRequest", signpostID: signpostID, "Request finished CODE:%ld", resultCode)
                if resultCode == 500 {
                    // Failed, so let's retry in a sec
                    let time = DispatchTime.now() + .seconds(Int(1))
                    DispatchQueue.main.asyncAfter(deadline: time) {
                        scheduleRequest(request, handler: handler)
                        _requestDidFinish()
                    }
                } else {
                    handler(completedRequest, resultCode, data)
                    _requestDidFinish()
                }
            }
        }
        if shouldGenerateDuplicateRequest() {
            let time = DispatchTime.now() + .milliseconds(Int(25))
            DispatchQueue.main.asyncAfter(deadline: time) {
                scheduleRequest(request) { (_, _, _) in }
            }
        }
    }

    private class func fakeParserForRequest(_ request: NetworkRequest) -> RequestParser? {
        if request.requestURL == "solars.apple.com/planets" {
            return MockRequestParser(cannedResult: [
                SolarSystemPlanet(name: "Mercury"),
                SolarSystemPlanet(name: "Venus"),
                SolarSystemPlanet(name: "Earth"),
                SolarSystemPlanet(name: "Mars"),
                SolarSystemPlanet(name: "Jupiter"),
                SolarSystemPlanet(name: "Saturn"),
                SolarSystemPlanet(name: "Uranus"),
                SolarSystemPlanet(name: "Neptune")
                ], parsingMilliseconds: UInt((arc4random() % 20) + 50))
        } else if request.requestURL.hasSuffix("/moons") {
            var moons: Int = 0
            switch request.groupingValue {
                case "Mercury": moons = 0
                case "Venus": moons = 0
                case "Earth": moons = 1
                case "Mars": moons = 2
                case "Jupiter": moons = 69
                case "Saturn": moons = 62
                case "Uranus": moons = 27
                case "Neptune": moons = 14
                default: break
            }
            let data: [SolarSystemMoon] = (0..<moons).map { val in return SolarSystemMoon(name: "\(val)", planet: request.groupingValue) }
            return MockRequestParser(cannedResult: data, parsingMilliseconds: UInt(arc4random() % 40))
        }
        return nil
    }

    private static var plannedResponses: [UInt:RequestParser] = [:]
}
