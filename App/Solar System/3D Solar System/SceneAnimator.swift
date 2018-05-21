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
        var wantsDisplayLinkAnimations = false
        if let displayLinkAnimationsEnVar = ProcessInfo.processInfo.environment["DisplayLinkAnimations"] {
            let enVar: NSString = displayLinkAnimationsEnVar as NSString
            wantsDisplayLinkAnimations = enVar.boolValue
        }
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
        /// >> This should block the main thread a bit
        RunLoop.current.run(until: Date().addingTimeInterval(0.5))
        //sleep(1)
        sceneController.updateAnimatedObjectsWithElapsedTime(elapsedTime)
    }
    
}

// DisplayLink class to replace CADisplayLink on macOS
#if os(OSX)
import AppKit

class DisplayLink {
    let timer  : CVDisplayLink
    let source : DispatchSourceUserDataAdd
    var callback : Optional<() -> ()> = nil
    var running : Bool { return CVDisplayLinkIsRunning(timer) }
    
    init?(callback : Optional<() -> ()>) {
        source = DispatchSource.makeUserDataAddSource(queue: DispatchQueue.main)
        self.callback = callback
        
        var timerRef : CVDisplayLink? = nil
        var successLink = CVDisplayLinkCreateWithActiveCGDisplays(&timerRef)
        
        if let timer = timerRef {
            successLink = CVDisplayLinkSetOutputCallback(timer, {
                                                            (timer : CVDisplayLink, currentTime : UnsafePointer<CVTimeStamp>, outputTime : UnsafePointer<CVTimeStamp>, _ : CVOptionFlags, _ : UnsafeMutablePointer<CVOptionFlags>, sourceUnsafeRaw : UnsafeMutableRawPointer?) -> CVReturn in
                
                                                            if let sourceUnsafeRaw = sourceUnsafeRaw {
                                                                let sourceUnmanaged = Unmanaged<DispatchSourceUserDataAdd>.fromOpaque(sourceUnsafeRaw)
                                                                sourceUnmanaged.takeUnretainedValue().add(data: 1)
                                                            }
                                                            
                                                            return kCVReturnSuccess
                                                            
            }, Unmanaged.passUnretained(source).toOpaque())
            
            guard successLink == kCVReturnSuccess else {
                NSLog("Failed to create timer with active display")
                return nil
            }
            
            // Connect to display
            successLink = CVDisplayLinkSetCurrentCGDisplay(timer, CGMainDisplayID())
            
            guard successLink == kCVReturnSuccess else {
                NSLog("Failed to connect to display")
                return nil
            }
            
            self.timer = timer
        }
        else {
            NSLog("Failed to create timer with active display")
            return nil
        }
        
        // Timer setup
        source.setEventHandler(handler: { [weak self] in self?.callback?() })
    }
    
    func start() {
        guard !running else { return }
        
        CVDisplayLinkStart(timer)
        source.resume()
    }
    
    func cancel() {
        guard running else { return }
        
        CVDisplayLinkStop(timer)
        source.cancel()
    }
    
    deinit {
        if running {
            cancel()
        }
    }
}
#endif
