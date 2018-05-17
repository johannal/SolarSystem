//
//  Copyright © 2018 Apple. All rights reserved.
//

import XCTest

class ExtraFavoritePlanetTests: XCTestCase {
    
    var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        self.app = XCUIApplication()
        self.app.launch()
    }
    
    func testAddingAndRemovingPlanetsFromFavoritesList() {
        self.app.buttons["ListIcon"].tap()
        
        for cell in self.app.tables.cells.allElementsBoundByIndex {
            cell.tap()

            self.app.buttons["Add to Favorites"].tap()

            self.app.alerts.buttons["OK"].tap()

            self.app.buttons["Planets"].tap()
        }
        
        self.app.buttons["Favorites"].tap()
        
        while true {
            guard let cell = self.app.tables.cells.allElementsBoundByIndex.first else {
                break
            }
            
            let startDragCoord = cell.coordinate(withNormalizedOffset: CGVector(dx: 1.0, dy: 0.5))
            let endDragCoord = cell.coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.5))
            startDragCoord.press(forDuration: 0.1, thenDragTo: endDragCoord)
        }
    }
}
