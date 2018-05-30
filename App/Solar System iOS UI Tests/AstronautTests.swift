//
//  Copyright © 2018 Apple. All rights reserved.
//

import XCTest

class AstronautTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        
        self.app = XCUIApplication()
        self.app.launchEnvironment = [
            "DisableAnimations": "YES"
        ]
        self.app.launch()
    }
    
    func testAstronautJumping() {
        self.app.buttons["ExperienceGravity"].tap()
        
        let heightElement = self.app.otherElements["Height"]
        
        for _ in 0 ..< 5 {
            let heightLabelCoord = self.app.staticTexts["HeightLabel"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
            let startingCoord = heightLabelCoord.withOffset(CGVector(dx: 0, dy: 400))
            
            heightElement.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).press(forDuration: 0, thenDragTo: startingCoord)
            
            for _ in 0 ..< 3 {
                self.app.images["Astronaut"].tap()
                
                let startingCoord = heightElement.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
                let newCoord = startingCoord.withOffset(CGVector(dx: 0, dy: -90))
                
                startingCoord.press(forDuration: 0, thenDragTo: newCoord)
            }
        }
    }
    
}
