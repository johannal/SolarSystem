//
//  NetworkModel.swift
//  Solar System iOS
//
//  Created by Kacper Harasim on 5/21/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

struct SolarSystemPlanet {
    let name: String
}

struct SolarSystemMoon {
    let name: String
    let planet: SolarSystemPlanet
}

public struct Request<Resource> {
    let url: String
    let belongingPlanet: SolarSystemPlanet?
    let data: [Resource]

    var groupingValue: String {
        if let planet = belongingPlanet {
            return planet.name
        }
        return "General"
    }


    static var planets: Request<SolarSystemPlanet> {
        let planets = [
            SolarSystemPlanet(name: "Mercury"),
            SolarSystemPlanet(name: "Venus"),
            SolarSystemPlanet(name: "Earth"),
            SolarSystemPlanet(name: "Mars"),
            SolarSystemPlanet(name: "Jupiter"),
            SolarSystemPlanet(name: "Saturn"),
            SolarSystemPlanet(name: "Uranus"),
            SolarSystemPlanet(name: "Neptune")
        ]
        return Request<SolarSystemPlanet>(url: "solars.apple.com/planets", belongingPlanet: nil, data: planets)
    }

    static func photo(of planet: SolarSystemPlanet) -> Request<Any> {
        return Request<Any>(url: "solars.apple.com/\(planet.name)/photo", belongingPlanet: planet, data: [])
    }

    static func news(about planet: SolarSystemPlanet) -> Request<Any> {
        return Request<Any>(url: "solars.apple.com/\(planet.name)/news", belongingPlanet: planet, data: [])
    }

    static func neighbours(of planet: SolarSystemPlanet) -> Request<Any> {
        return Request<Any>(url: "solars.apple.com/\(planet.name)/neighbours", belongingPlanet: planet, data: [])
    }

    static func moons(for planet: SolarSystemPlanet) -> Request<SolarSystemMoon> {
        var moons: Int = 0
        switch planet.name {
        case "Mercury":
            moons = 0
        case "Venus":
            moons = 0
        case "Earth":
            moons = 1
        case "Mars":
            moons = 2
        case "Jupiter":
            moons = 69
        case "Saturn":
            moons = 62
        case "Uranus":
            moons = 27
        case "Neptune":
            moons = 14
        default:
            break
        }
        let data: [SolarSystemMoon] = (0..<moons).map { val in return SolarSystemMoon(name: "\(val)", planet: planet) }
        return Request<SolarSystemMoon>(url: "solars.apple.com/\(planet.name)/moons", belongingPlanet: planet, data: data)
    }

    static func photo(of moon: SolarSystemMoon) -> Request<Any> {
        return Request<Any>(url: "solars.apple.com/moons/\(moon.name)/image", belongingPlanet: moon.planet, data: [])
    }

    static func news(about moon: SolarSystemMoon) -> Request<Any> {
        return Request<Any>(url: "solars.apple.com/moons/\(moon.name)/news", belongingPlanet: moon.planet, data: [])
    }
}
