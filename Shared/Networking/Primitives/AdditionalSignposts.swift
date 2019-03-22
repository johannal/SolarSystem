//
//  SignpostAPI.swift
//  Solar System
//
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import _SwiftOSOverlayShims
import os.signpost

public func os_signpost(_ type: OSSignpostType, dso: UnsafeRawPointer = #dsohandle, log: OSLog, name: StaticString, signpostID: OSSignpostID = .exclusive, _ format: StaticString, _ arguments: CVarArg...) {
    guard log.signpostsEnabled else { return }
    let ra = _swift_os_log_return_address()
    name.withUTF8Buffer { (nameBuf: UnsafeBufferPointer<UInt8>) in
        nameBuf.baseAddress!.withMemoryRebound(to: CChar.self, capacity: nameBuf.count) { nameStr in
            format.withUTF8Buffer { (formatBuf: UnsafeBufferPointer<UInt8>) in
                formatBuf.baseAddress!.withMemoryRebound(to: CChar.self, capacity: formatBuf.count) { formatStr in
                    withVaList(arguments) { valist in
                        _swift_os_signpost_with_format(dso, ra, log, type, nameStr, signpostID.rawValue, formatStr, valist)
                    }
                }
            }
        }
    }
}

public func os_log(_ type: OSLogType, dso: UnsafeRawPointer = #dsohandle, log: OSLog = .default, _ message: StaticString, _ args: CVarArg...) {
    guard log.isEnabled(type: type) else { return }
    let ra = _swift_os_log_return_address()
    message.withUTF8Buffer { (buf: UnsafeBufferPointer<UInt8>) in
        buf.baseAddress!.withMemoryRebound(to: CChar.self, capacity: buf.count) { str in
            withVaList(args) { valist in
                _swift_os_log(dso, ra, log, type, str, valist)
            }
        }
    }
}
