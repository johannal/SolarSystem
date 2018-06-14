//
//  SceneAnimator.swift
//  Solar System
//
//  Copyright © 2018 Apple. All rights reserved.
//

#if os(macOS)
import Cocoa
#else
import UIKit
#endif

class SceneAnimator: NSObject {
    
    // Animation properties
    #if os(macOS)
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
    
    static var wantsDisplayLinkAnimations: Bool = false
    
    func setupDisplayLinkAnimations() {
        if SceneAnimator.wantsDisplayLinkAnimations {
            // Setup display link
            #if os(macOS)
            timer = DisplayLink(callback: {
                self.tick(timestamp: CACurrentMediaTime() as TimeInterval)
            })
            timer.start()
            #else
            timer = CADisplayLink(target: self, selector: #selector(tick))
            timer?.add(to: .main, forMode: RunLoop.Mode.default)
            #endif
        }
    }
    
    // Display Link callback
    @objc func tick(timestamp: TimeInterval) {
        if lastTimestamp == 0 {
            lastTimestamp = timestamp
            return
        }
        
        let elapsedTime = timestamp - lastTimestamp
        lastTimestamp = timestamp
        
        if SceneViewController.wantsAutomaticNewsFeedUpdates {
            let variance_ms: UInt32 = 400
            let minDelay_ms:UInt32 = 100
            let delay_s = Double(arc4random_uniform(variance_ms) + minDelay_ms) / 1000.0
            RunLoop.current.run(mode: RunLoop.Mode.common, before: Date().addingTimeInterval(delay_s))
        }
    
        // Get elapsed time by calculating offset between last time stamp and now
        sceneController.updateAnimatedObjectsWithElapsedTime(elapsedTime)
    }
}
