//
//  Copyright © 2018 Apple. All rights reserved.
//

import XCTest

class NavigationTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        
        self.app = XCUIApplication()
        self.app.launchEnvironment = [
            "DisableAnimations": "YES"
        ]
        self.app.launch()
    }
    
    func testNavigationThroughDifferentScreens() {
        for _ in 0 ..< 15 {
            self.app.buttons["Settings"].tap()
            
            self.app.buttons["Share with a friend"].tap()
            
            RunLoop.main.run(until: Date(timeIntervalSinceNow: 1))
            
            self.app.buttons["Cancel"].tap()
            
            self.app.buttons["Done"].tap()
            
            self.app.buttons["ExperienceGravity"].tap()
            
            RunLoop.main.run(until: Date(timeIntervalSinceNow: 1))
            
            self.app.buttons["Back"].tap()
            
            self.app.buttons["PlanetDetailsIcon"].tap()
            
            RunLoop.main.run(until: Date(timeIntervalSinceNow: 2))
            
            self.app.buttons["OrbitalViewIcon"].tap()
            
            self.app.buttons["ListIcon"].tap()
            
            self.app.buttons["Favorites"].tap()
            
            self.app.buttons["Done"].tap()
            
            self.app.buttons["Done"].tap()
        }
        
    }
    
}
