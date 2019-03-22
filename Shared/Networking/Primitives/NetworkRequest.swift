//
//  NetworkRequest.swift
//  Solar System
//
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

enum UpdateError: Error {
    case requestFailed
}

protocol NetworkRequest {
    var requestURL: String { get }
    var identifier: UInt { get }
    var groupingValue: String { get set }

    init(requestURL: String)

    func perform(queue: DispatchQueue, completion: @escaping (NetworkRequest, Int, Data?)->())
}
