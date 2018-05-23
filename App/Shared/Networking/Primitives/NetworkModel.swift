//
//  NetworkModel.swift
//  Solar System iOS
//
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

struct SolarSystemPlanet {
    let name: String
}

struct SolarSystemMoon {
    let name: String
    let planet: String
}

struct News {}
struct Photo {}

protocol UpdatingCelestial {
    associatedtype RequestType: NetworkRequest
    var newsUpdateRequest: RequestType { get }
    var photoUpdateRequest: RequestType { get }
    var baseURLComponent: String { get }
    var name: String { get }
    var planetName: String { get }
}

extension UpdatingCelestial {
    func _requestWithSuffix(_ suffix: String) -> RequestType {
        var request = RequestType(requestURL: "solars.apple.com/\(self.baseURLComponent)/\(self.name)/\(suffix)")
        request.groupingValue = self.planetName
        return request;
    }
    var newsUpdateRequest: RequestType { return _requestWithSuffix("news") }
    var photoUpdateRequest: RequestType { return _requestWithSuffix("image") }
}

extension SolarSystemPlanet: UpdatingCelestial {
    typealias RequestType = MockNetworkRequest
    var baseURLComponent: String { return "planets" }
    var moonRequest: RequestType { return _requestWithSuffix("moons") }
    var planetName: String { return name }
}

extension SolarSystemMoon: UpdatingCelestial {
    typealias RequestType = MockNetworkRequest
    var baseURLComponent: String { return "\(planetName)/moons" }
    var planetName: String { return planet }
}

