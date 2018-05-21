//
//  NetworkModel.swift
//  Solar System iOS
//
//  Created by Kacper Harasim on 5/21/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

struct Planet {
    let name: String
}

struct Moon {
    let name: String
    let planet: Planet
}

public struct Request<Resource> {
    let url: String
    let belongingPlanet: Planet?
    let data: [Resource]

    var userIdentifierString: String {
        if let planet = belongingPlanet {
            return planet.name
        }
        return ""
    }


    static var planets: Request<Planet> {
        let planets = [
            Planet(name: "Mercury"),
            Planet(name: "Venus"),
            Planet(name: "Earth"),
            Planet(name: "Mars"),
            Planet(name: "Jupiter"),
            Planet(name: "Saturn"),
            Planet(name: "Uranus"),
            Planet(name: "Neptune")
        ]
        return Request<Planet>(url: "solars.apple.com/planets", belongingPlanet: nil, data: planets)
    }

    static func photo(of planet: Planet) -> Request<Any> {
        return Request<Any>(url: "solars.apple.com/\(planet.name)/photo", belongingPlanet: planet, data: [])
    }

    static func news(about planet: Planet) -> Request<Any> {
        return Request<Any>(url: "solars.apple.com/\(planet.name)/news", belongingPlanet: planet, data: [])
    }

    static func neighbours(of planet: Planet) -> Request<Any> {
        return Request<Any>(url: "solars.apple.com/\(planet.name)/neighbours", belongingPlanet: planet, data: [])
    }

    static func moons(for planet: Planet) -> Request<Moon> {
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
        let data: [Moon] = (0..<moons).map { val in return Moon(name: "\(val)", planet: planet) }
        return Request<Moon>(url: "solars.apple.com/\(planet.name)/moons", belongingPlanet: planet, data: data)
    }

    static func photo(of moon: Moon) -> Request<Any> {
        return Request<Any>(url: "solars.apple.com/moons/\(moon.name)/image", belongingPlanet: moon.planet, data: [])
    }

    static func news(about moon: Moon) -> Request<Any> {
        return Request<Any>(url: "solars.apple.com/moons/\(moon.name)/news", belongingPlanet: moon.planet, data: [])
    }
}
