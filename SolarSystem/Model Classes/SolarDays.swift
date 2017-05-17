//
//  SolarDays.swift
//  Science
//
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

/**
 The time between successive meridian transits of the sun at a particular place.
 */
struct SolarDays {
    
    /// 1 Sidereal Period, or how long it takes the earth to rotate around the sun
    static let earthOrbitalPeriod: SolarDays = 365.256363
    
    /// The value of this instance
    var value: Double
    
}

extension SolarDays: ExpressibleByFloatLiteral {
    init(floatLiteral value: Double) {
        self.value = value
    }
}

extension SolarDays: Comparable {
    static func <(lhs: SolarDays, rhs: SolarDays) -> Bool {
        return lhs.value < rhs.value
    }
    
    static func ==(lhs: SolarDays, rhs: SolarDays) -> Bool {
        return lhs.value == rhs.value
    }
}

extension SolarDays: CustomDebugStringConvertible {
    var debugDescription: String {
        return "\(self.value) solar days"
    }
}
