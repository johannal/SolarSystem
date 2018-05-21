//
//  NetworkRequestScheduler.swift
//  Solar System Mac
//
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import os.log

final class NetworkRequestScheduler {
    private static let callbackQueue = DispatchQueue(label: "com.demo.SolarSystem.networkCallbacks")
    private static let parsingQueue = DispatchQueue.main

    // DEMO TODO: substitute in real Swift API from overlay: <rdar://problem/39305137> SOTU DEMO: Add os_signpost overlay
    private static let logger = Logger()

    private static let solarNetworkingLog = OSLog(subsystem: "com.demo.SolarSystem", category: "Networking")

    class func scheduleParsingTask(_ identifier: UInt, _ data: Data, workItem: @escaping (RequestParser)->Void) {
        let parser = MockRequestParser(data: data)
        parsingQueue.async {
            logger.parsingStarted(identifier, dataSize: data.count)
            workItem(parser)
            logger.parsingFinished(identifier)
            usleep(1000 * 100)
        }
    }

    class func scheduleRequest<T: NetworkRequest>(_ request: T, handler: @escaping (T, Int, Data?)->Void) {
        logger.requestStarted(request.identifier, url: request.requestURL, type: "GET")
        request.perform(queue: callbackQueue) { (completedRequest, resultCode, data) in
            logger.requestFinished(request.identifier, code: resultCode)
            handler(completedRequest, resultCode, data)
        }
    }
}
