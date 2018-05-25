//
//  SignpostAPI.swift
//  Solar System
//
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import os.signpost

public func os_signpost(_ type: OSSignpostType, log: OSLog, name: StaticString, signpostID: OSSignpostID, _ format: StaticString, _ arguments: CVarArg...) {
    os_signpost(type: type, log: log, name: name, signpostID: signpostID, format, arguments)
}
