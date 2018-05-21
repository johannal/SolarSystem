//
//  SceneAnimator.swift
//  Solar System
//
//  Copyright © 2018 Apple. All rights reserved.
//

import Cocoa

class SceneAnimator: NSObject {
    
    // Animation properties
    #if os(OSX)
    var timer: DisplayLink!
    #else
    var timer: CADisplayLink!
    #endif
    var lastTimestamp: TimeInterval = 0
    
    var sceneController: SceneController
    
    init(sceneController: SceneController) {
        self.sceneController = sceneController
        
        super.init()
        
        // Setup display link driven animation if necessary
        setupDisplayLinkAnimations()
    }
    
    // MARK: - Display Link Animations
    
    static var wantsDisplayLinkAnimations: Bool {
        let wantsDisplayLinkAnimations = UserDefaults.standard.bool(forKey: "DisplayLinkAnimations")
        return wantsDisplayLinkAnimations
    }
    
    func setupDisplayLinkAnimations() {
        if SceneAnimator.wantsDisplayLinkAnimations {
            // Setup display link
            #if os(OSX)
            timer = DisplayLink(callback: {
                self.tick(timestamp: CACurrentMediaTime() as TimeInterval)
            })
            timer.start()
            #else
            timer = CADisplayLink(target: self, selector: #selector(tick))
            timer?.add(to: .main, forMode: .defaultRunLoopMode)
            #endif
        }
    }
    
    // Display Link callback
    func tick(timestamp: TimeInterval) {
        if (lastTimestamp == 0) {
            lastTimestamp = timestamp
            return
        }
        
        let elapsedTime = timestamp - lastTimestamp
        lastTimestamp = timestamp
        
        // Get elapsed time by calculating offset between last time stamp and now
        sceneController.updateAnimatedObjectsWithElapsedTime(elapsedTime)
    }
    
}
