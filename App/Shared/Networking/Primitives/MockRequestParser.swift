//
//  MockRequestParser.swift
//  Solar System
//
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

private struct Owner: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let age: UInt
    let city: String
}

final class MockRequestParser: RequestParser {
    private let data: Data
    private let result: [Any]?
    private let delay: UInt
    required init(data: Data) {
        self.data = data
        self.result = nil
        self.delay = 0
    }
    required init(cannedResult: [Any]?, parsingMilliseconds: UInt) {
        self.data = Data()
        self.result = cannedResult
        self.delay = parsingMilliseconds
    }

    var bytes: Int {
        return max(data.count, Int(delay*100))
    }

    private func performParsing() {
        let owner = Owner(firstName: "John", lastName: "Appleseed", email: "jappleseed@apple.com", age: 40, city: "Cupertino")
        let owners = Array(repeating: owner, count: bytes)
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        do {
            let data = try encoder.encode(owners)
            _ = try decoder.decode([Owner].self, from: data)
        } catch { }
    }

    func parse<T>() throws -> [T] {
        if delay > 0 {
            performParsing()
        } else {
            usleep(useconds_t(data.count/100))
        }
        return (result as? [T]) ?? []
    }
}
