//
//  AstronomicalObject.swift
//  Solar System
//
//  Created by Sebastian Fischer on 25.04.18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

class AstronomicalObject {
    
    let diameter: Double
    let orbitalRadius: Double
    let orbitalPeriod: Double
    let rotationalPeriod: Double
    let rotationDirectionIsForward: Bool
    let gravity: Double
    
    let name: String
    let description: String
    let additionalDetails: String
    
    let diffuseTextureName: ImageName
    let normalTextureName: ImageName?
    let specularTextureName: ImageName?
    
    var browserURL: URL {
        return Bundle.main.url(forResource: self.name.lowercased(), withExtension: "webarchive")!
    }
    
    var globeImage: Image {
        let imageName: Any = name.appending("Globus")
        return Image(named: imageName as! ImageName)!
    }
    
    static var allKnownObjects: [AstronomicalObject] {
        let planetInfoPath = Bundle.main.path(forResource: "PlanetDetails", ofType: "plist")!
        guard let planetDetails = NSArray.init(contentsOfFile: planetInfoPath) as? [Dictionary<String, Any>] else {
            fatalError("Unable to process Planet Details plist.")
        }
        return planetDetails.map { dict in AstronomicalObject.init(dictionary: dict) }
    }
    
    static var favoriteObjects: [AstronomicalObject] {
        let knownObjects = allKnownObjects
        var favoriteObjects: [AstronomicalObject] = []
        let favoriteIndices = UserDefaults.standard.object(forKey: "FavoritePlanets")
        if let favoriteIndices = favoriteIndices as? [Int] {
            for idx in favoriteIndices {
                let object = knownObjects[idx]
                favoriteObjects.append(object)
            }
        }
        
        return favoriteObjects
    }
    
    init(dictionary: Dictionary<String, Any>) {
        diameter = dictionary["diameter"] as! Double
        orbitalRadius = dictionary["orbitalRadius"] as! Double
        orbitalPeriod = dictionary["orbitalPeriod"] as! Double
        rotationalPeriod = dictionary["rotationalPeriod"] as! Double
        
        if let rotateForward = dictionary["rotationDirectionIsForward"] as? Bool {
            rotationDirectionIsForward = rotateForward
        }
        else {
            rotationDirectionIsForward = true
        }
        
        gravity = dictionary["gravity"] as! Double
        
        name = dictionary["name"] as! String
        description = dictionary["description"] as! String
        additionalDetails = dictionary["additionalDetails"] as! String
        
        diffuseTextureName = dictionary["diffuseTexture"] as! ImageName
        normalTextureName = dictionary["normalTextureName"] as? ImageName
        specularTextureName = dictionary["specularTextureName"] as? ImageName
    }
    
    func addToFavorites() {
        if let index = AstronomicalObject.allKnownObjects.index(where: {$0.name == name}) {
            if var favorites = UserDefaults.standard.object(forKey: "FavoritePlanets") as? [Int] {
                favorites.append(index)
                UserDefaults.standard.setValue(favorites, forKey: "FavoritePlanets")
            }
        }
    }
}
