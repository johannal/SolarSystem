//
//  RequestParser.swift
//  Solar System
//
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

protocol RequestParser {
    var bytes: Int { get }

    init(data: Data)

    func parse<T>() throws -> [T]
}
