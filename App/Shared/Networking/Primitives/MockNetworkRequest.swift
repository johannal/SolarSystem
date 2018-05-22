//
//  MockNetworkRequest.swift
//  Solar System
//
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

struct MockNetworkRequest: NetworkRequest {
    static private func _randomReturnCode() -> Int {
        let random = arc4random()
        return ((random % 100) == 0) ? 500 : 200
    }
    static private func _randomDeadline() -> DispatchTime {
        let requestMilisec = arc4random() % 150 + 50
        return DispatchTime.now() + .milliseconds(Int(requestMilisec))
    }
    static private func _randomData() -> Data {
        let dataSize = arc4random() % 75 + 20
        return Data(count: Int(dataSize))
    }

    static private let identifierQueue = DispatchQueue(label: "identifierAtomicQueue")
    static private var nextId: UInt = 0
    static private func _generateIdentifier() -> UInt {
        var generated: UInt = 0
        MockNetworkRequest.identifierQueue.sync {
            generated = nextId
            nextId += 1
        }
        return generated
    }

    let requestURL: String
    let identifier: UInt
    var groupingValue: String = ""

    init(requestURL: String) {
        self.requestURL = requestURL
        self.identifier = MockNetworkRequest._generateIdentifier()
    }

    func perform(queue: DispatchQueue, completion: @escaping (NetworkRequest, Int, Data?) -> ()) {
        queue.asyncAfter(deadline: MockNetworkRequest._randomDeadline()) {
            let retCode = MockNetworkRequest._randomReturnCode()
            let retData = MockNetworkRequest._randomData()
            completion(self, retCode, retData)
        }
    }

    static func == (lhs: MockNetworkRequest, rhs: MockNetworkRequest) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
