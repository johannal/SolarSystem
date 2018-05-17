//
//  Copyright © 2018 Apple. All rights reserved.
//

import XCTest

class ExtraAstronautTests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false

        self.app = XCUIApplication()

        self.app.launch()
    }

    func testAstronautJumping() {
        self.app.buttons["ExperienceGravity"].tap()
        
        let heightElement = self.app.otherElements["Height"]
        
        let originalCoord = heightElement.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        let startingCoord = originalCoord.withOffset(CGVector(dx: 0, dy: 150))
            
        originalCoord.press(forDuration: 0, thenDragTo: startingCoord)
        
        for _ in 0 ..< 3 {
            self.app.images["Astronaut"].tap()
            
            let startingCoord = heightElement.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
            let newCoord = startingCoord.withOffset(CGVector(dx: 0, dy: -80))
            
            startingCoord.press(forDuration: 0, thenDragTo: newCoord)
        }
    }

}
