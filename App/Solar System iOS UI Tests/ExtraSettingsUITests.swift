//
//  Copyright © 2018 Apple. All rights reserved.
//

import XCTest

class ExtraSettingsUITests: XCTestCase {

    func testSettings() {
        let app = XCUIApplication()
        
        app.launch()
        
        app.buttons["Settings"].tap()
        
        app.cells.containing(.staticText, identifier: "Simulate gravity").switches.element.tap()
        
        app.cells.containing(.staticText, identifier: "Gravity mode").segmentedControls.buttons["Moon"].tap()
        
        app.cells.containing(.staticText, identifier: "Show dwarf planets").switches.element.tap()
        
        let radiusSlider = app.cells.containing(.staticText, identifier: "Visible radius (au)").sliders.element
        
        let minValue = 1
        let maxValue = 35
        let strideValue = 5
        
        var lastValue = minValue
        for i in stride(from: minValue, through: maxValue, by: strideValue) {
            let startingCoordinate = radiusSlider.coordinate(withNormalizedOffset: CGVector(dx: CGFloat(lastValue)/CGFloat(maxValue), dy: 0.5))
            let targetCoordinate = radiusSlider.coordinate(withNormalizedOffset: CGVector(dx: CGFloat(i)/CGFloat(maxValue), dy: 0.5))
            
            startingCoordinate.press(forDuration: 1, thenDragTo: targetCoordinate)
            
            lastValue = i
        }
        
        app.cells.containing(.staticText, identifier: "Distance units").textFields.element.tap()
        
        for _ in 0 ..< 2 {
             app.pickerWheels.element.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.6)).tap()
        }
    }
}
