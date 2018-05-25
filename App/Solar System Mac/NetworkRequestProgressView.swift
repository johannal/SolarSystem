//
//  NetworkRequestProgressView.swift
//  Solar System Mac
//
//  Copyright © 2018 Apple. All rights reserved.
//

import Cocoa

class NetworkRequestProgressView: NSView {
    @IBOutlet weak var spinner: NSProgressIndicator!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Start spinner
        spinner.startAnimation(nil)
        
        // Style layer
        layer?.cornerRadius = frame.height/2.0
        layer?.masksToBounds = true
        layer?.borderColor = NSColor.systemBlue.cgColor
        layer?.borderWidth = 2.0
        
        // Hide progress view by default
        alphaValue = 0.0
    }
    
    func show(animated: Bool) {
        // Animate visible
        NSAnimationContext.runAnimationGroup { context in
            context.duration = animated ? 1.0 : 0.0
            self.animator().alphaValue = 1.0
        }
    }
    
    func hide(animated: Bool) {
        alphaValue = 0.0
        
        // Animate hidden
        NSAnimationContext.runAnimationGroup { context in
            context.duration = animated ? 1.0 : 0.0
            self.animator().alphaValue = 0.0
        }
    }
}
