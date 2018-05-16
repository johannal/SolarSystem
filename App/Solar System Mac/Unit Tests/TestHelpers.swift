//
//  TestHelpers.swift
//  Solar System Mac Unit Tests
//
//  Created by Administrator on 4/17/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

func sleepMap(_ testName: String) -> UInt32 {
    switch testName {
    case "testCalculatePlanetMass()":
        return 1340
    case "testCalculatePlanetDensity()":
        return 800
    case "testCalculatePlanetOrbitingVelocity()":
        return 340
    case "testAddMoon()":
        return 600
    case "testAddNearbyNeptunian()":
        return 500
    case "removeAddNearbyNeptunian()":
        return 400
    case "testFindNearestObject()":
        return 800
    case "testPositionRelativeToStar()":
        return 300
    case "testMoonName()":
        return 450
    case "testMoonColor()":
        return 600
    case "testFindParentPlanet()":
        return 860
    case "testPlanetSiblings()":
        return 340
    case "testOrbitPosition()":
        return 750
    case "testSolarSystemPosition()":
        return 640
    case "testDistanceBetweenPlanets()":
        return 860
    case "testCreateDistantObjects()":
        return 900
    case "testStarPosition()":
        return 500
    case "testStarMass()":
        return 700
    case "testStarDensity()":
        return 600
    case "testStarAngularVelocity()":
        return 740
    case "testFindNearestDistance()":
        return 600
    case "testFindFarthestDistance()":
        return 900
    default:
        return 0
    }
}

func testSleep(_ testName: String) {
    let napTime = sleepMap(testName)
    let ms: UInt32 = 1000
    usleep(napTime * ms)
}
