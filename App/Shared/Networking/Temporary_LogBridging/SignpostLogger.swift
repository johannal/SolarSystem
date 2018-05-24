//
//  SignpostLogger.swift
//  Solar System
//
//  Created by Kacper Harasim on 5/15/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

func os_signpost_interval_begin(_ log: OSLog, _ identifier: UInt, _ name: String, _ format: String) {
    swift_os_signpost_impl(log, os_signpost_id_t(identifier), OS_SIGNPOST_INTERVAL_BEGIN, name, format)
}
func os_signpost_interval_end(_ log: OSLog, _ identifier: UInt, _ name: String, _ format: String) {
    swift_os_signpost_impl(log, os_signpost_id_t(identifier), OS_SIGNPOST_INTERVAL_END, name, format)
}
