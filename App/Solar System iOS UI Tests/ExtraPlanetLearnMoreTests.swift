//
//  Copyright © 2018 Apple. All rights reserved.
//

import XCTest

class ExtraPlanetLearnMoreTests: XCTestCase {

    func testLearnMore() {
        let app = XCUIApplication()
        app.launchEnvironment = [ "TESTING_ENVIRONMENT" : "YES" ]
        
        app.launch()
        
        app.buttons["ListIcon"].tap()
        
        for cell in app.tables.cells.allElementsBoundByIndex {
            cell.tap()
            
            app.buttons["Learn More"].tap()
            
            let planetsButton = app.buttons["Planets"]
            _ = planetsButton.waitForExistence(timeout: 15)
            planetsButton.tap()
        }
    }

}
