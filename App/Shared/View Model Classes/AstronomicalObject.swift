//
//  AstronomicalObject.swift
//  Solar System
//
//  Created by Sebastian Fischer on 25.04.18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

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
}
