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
    required init(data: Data) {
        self.data = data;
    }

    var bytes: Int {
        return data.count
    }

    private func performParsing() {
        let length = data.count
        let owner = Owner(firstName: "John", lastName: "Appleseed", email: "jappleseed@apple.com", age: 40, city: "Cupertino")
        let owners = Array(repeating: owner, count: length)
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        do {
            let data = try encoder.encode(owners)
            _ = try decoder.decode([Owner].self, from: data)
        } catch { }
    }

    func parse<T>() throws -> [T] {
        performParsing()
        return []
    }
}
