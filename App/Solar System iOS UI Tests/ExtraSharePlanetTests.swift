//
//  Copyright © 2018 Apple. All rights reserved.
//

import XCTest

class ExtraSharePlanetTests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false

        self.app = XCUIApplication()
        self.app.launchEnvironment = ["DisableAnimations": "YES"]
        self.app.launch()
    }

    func testSharingPlanet() {
        self.app.buttons["ListIcon"].tap()
        
        for cell in self.app.tables.cells.allElementsBoundByIndex {
            cell.tap()
            
            self.app.buttons["Share"].tap()
            
            self.app.buttons["Cancel"].tap()
            
            self.app.buttons["Planets"].tap()
        }
    }

}
