//
//  NetworkRequest.swift
//  Solar System
//
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

protocol NetworkRequest: Equatable {
    var requestURL: String { get }
    var identifier: UInt { get }

    init(requestURL: String)
    func perform(queue: DispatchQueue, completion: @escaping (Self, Int, Data?)->())
}
