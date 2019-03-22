//
//  Copyright © 2018 Apple. All rights reserved.
//

import XCTest

class ShareAppTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        
        self.app = XCUIApplication()
        self.app.launchEnvironment = [
            "DisableAnimations": "YES"
        ]
        self.app.launch()
    }
    
    func testShareAppWithAFriend() {
        self.app.buttons["Settings"].tap()
        
        for _ in 0 ..< 6 {
            self.app.buttons["Share with a friend"].tap()
            
            var names = [String]()
            
            let contactsTable = self.app.tables["ContactsListView"]
            _ = contactsTable.waitForExistence(timeout: 10)
            
            for cell in contactsTable.cells.allElementsBoundByIndex {
                names.append(cell.label)
            }
            
            for name in names {
                self.app.searchFields.element.tap()
                
                RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.25))
                
                self.app.searchFields.element.typeText(name)
                
                self.app.tables.matching(NSPredicate(format: "label LIKE \"Search results\"")).cells.firstMatch.tap()
                
                RunLoop.main.run(until: Date(timeIntervalSinceNow: 1))
                
                self.app.buttons["Search"].tap()
                
                RunLoop.main.run(until: Date(timeIntervalSinceNow: 1))
                
                let deleteString = name.map({ _ in XCUIKeyboardKey.delete.rawValue }).joined()
                
                self.app.searchFields.element.tap()
                
                RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.25))
                
                self.app.typeText(deleteString)
            }
            
            self.app.otherElements.children(matching: .button).matching(identifier: "Cancel").element.tap()
            
            RunLoop.main.run(until: Date(timeIntervalSinceNow: 1))
            
            self.app.navigationBars.buttons["Cancel"].tap()
        }
    }
    
}
