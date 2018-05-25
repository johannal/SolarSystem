//
//  DisplayLink.swift
//  Solar System Mac
//
//  Copyright © 2018 Apple. All rights reserved.
//

// DisplayLink class to replace CADisplayLink on macOS
#if os(macOS)
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
