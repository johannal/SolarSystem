//
//  Copyright © 2018 Apple. All rights reserved.
//

import XCTest

class PlanetLearnMoreTests: XCTestCase {

    func testLearnMore() {
        let app = XCUIApplication()
        app.launchEnvironment = [
            "DisableAnimations": "YES",
            "TESTING_ENVIRONMENT" : "YES"
        ]
        
        app.launch()
        
        app.buttons["ListIcon"].tap()
        
        for _ in 0 ..< 4 {
            for cell in app.tables.cells.allElementsBoundByIndex {
                cell.tap()
                
                app.buttons["Learn More"].tap()
                
                let planetsButton = app.buttons["Planets"]
                _ = planetsButton.waitForExistence(timeout: 15)
                planetsButton.tap()
            }
        }
    }

}
