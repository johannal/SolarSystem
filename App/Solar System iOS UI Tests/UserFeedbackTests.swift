//
//  Copyright © 2018 Apple. All rights reserved.
//

import XCTest

class UserFeedbackTests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false

        self.app = XCUIApplication()
        self.app.launchEnvironment = [
            "DisableAnimations": "YES"
        ]
        self.app.launch()
    }

    func testSendingFeedback() {
        self.app.buttons["Settings"].tap()
        
        let feedbackArray = [
            "Hello, I really enjoy using the Solar System app! It's really useful for learning about the details of our spot in the Milky Way.\nCould you please add Pluto in a future software update? :)",
            "Hi. I'm an educator using the Solar System app to teach my students about space. I love it! Thank you for this app, and please continue to add new features!",
            "Hello, any chance that you could add additional parts of the Milky Way to explore? I'd love to know more about areas of space outside of our local solar system. Thanks!"
        ]
        
        for _ in 0 ..< 15 {
            for feedback in feedbackArray {
                self.app.buttons["Feedback"].tap()
                
                self.app.textViews.element.tap()
                self.app.textViews.element.typeText(feedback)
                self.app.buttons["Send"].tap()
            }
        }
    }

}
