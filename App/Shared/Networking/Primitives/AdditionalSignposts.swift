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
        // Since dladdr is in libc, it is safe to unsafeBitCast
        // the cstring argument type.
        nameBuf.baseAddress!.withMemoryRebound(
            to: CChar.self, capacity: nameBuf.count
        ) { nameStr in
            format.withUTF8Buffer { (formatBuf: UnsafeBufferPointer<UInt8>) in
                // Since dladdr is in libc, it is safe to unsafeBitCast
                // the cstring argument type.
                formatBuf.baseAddress!.withMemoryRebound(
                    to: CChar.self, capacity: formatBuf.count
                ) { formatStr in
                    withVaList(arguments) { valist in
                        _swift_os_signpost_with_format(dso, ra, log, type, nameStr, signpostID.rawValue, formatStr, valist)
                    }
                }
            }
        }
    }
}
