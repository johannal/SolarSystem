//
//  Copyright © 2018 Apple. All rights reserved.
//

import XCTest

class DeleteFavoritePlanetsTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        self.app = XCUIApplication()
        self.app.launchEnvironment = [
            "TESTING_ENVIRONMENT" : "YES",
            "DisableAnimations": "YES"
        ]
        self.app.launch()
    }
    
    func testDeleteThenAddFavorites() {
        self.app.buttons["ListIcon"].tap()
        
        for _ in 0 ..< 4 {
            self.app.buttons["Favorites"].tap()
            
            while true {
                guard let cell = self.app.tables.cells.allElementsBoundByIndex.first else {
                    break
                }
                
                let startDragCoord = cell.coordinate(withNormalizedOffset: CGVector(dx: 1.0, dy: 0.5))
                let endDragCoord = cell.coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.5))
                startDragCoord.press(forDuration: 0.1, thenDragTo: endDragCoord)
            }
            
            self.app.buttons["Done"].tap()
            
            for cell in self.app.tables.cells.allElementsBoundByIndex {
                cell.tap()
                
                self.app.buttons["Add to Favorites"].tap()
                
                self.app.alerts.buttons["OK"].tap()
                
                self.app.buttons["Planets"].tap()
            }
        }
    }
}
