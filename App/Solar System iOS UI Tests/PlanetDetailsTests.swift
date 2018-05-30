//
//  Copyright © 2018 Apple. All rights reserved.
//

import XCTest

class PlanetDetailsTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        self.app = XCUIApplication()
        self.app.launchEnvironment = [
            "DisableAnimations": "YES"
        ]
        self.app.launch()
    }
    
    func testViewingPlanetDetails() {
        self.app.buttons["PlanetDetailsIcon"].tap()
        
        for _ in 0 ..< 20 {
            RunLoop.main.run(until: Date(timeIntervalSinceNow: 2))
            self.app.buttons["RightArrow"].tap()
        }
    }

}
