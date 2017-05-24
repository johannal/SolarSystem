//
//  MoonJumperViewController.swift
//  Science
//
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import CoreMotion

let maxJumpHeight: Int = 300 // ft
let requiredAccellerationScaleFactor = 70.0 // Higher means you need less force to trigger a height

class MoonJumperViewController: UIViewController {
    
    @IBOutlet weak var groundView: UIView!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightIndicatorView: UIView!
    @IBOutlet weak var heightIndicatorYConstraint: NSLayoutConstraint!
    @IBOutlet weak var astronautView: UIView!
    
    let manager = CMMotionManager()
    var maxGravity = 0.0
    var selectedHeight = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup initial state
        // TODO
        
        // Monitor motion
        manager.deviceMotionUpdateInterval = 0.05
        if manager.isDeviceMotionAvailable {
            
            manager.startDeviceMotionUpdates(to: .main, withHandler: { [weak self] (deviceMotion, error) in
                let userAcceleration = deviceMotion!.userAcceleration
                let gravity = userAcceleration.y + 1.0 * 9.81
                
                let selectedHeight = Double(self!.selectedHeight)
                let requiredAcceleration = 10 + selectedHeight / requiredAccellerationScaleFactor
                
                if gravity > requiredAcceleration {
                    self?.heightLabel.textColor = UIColor.green
                    
                    DispatchQueue.main.async {
                        self?.reachedSelectedHeight()
                    }
                }
            })
        }
    }
    
    func reachedSelectedHeight() {
        // Update astronaut
        let yLocation = view.convert(heightIndicatorView.center, from: heightIndicatorView.superview!).y
        let astronautBottomY = view.bounds.height - yLocation - groundView.bounds.height
        
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: .beginFromCurrentState, animations: {
            self.astronautView.transform = CGAffineTransform.init(translationX: 0.0, y: -astronautBottomY)
        }, completion: nil)
        
        // TODO: Add code here to step through
        print("😱")
    }
    
    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
        let yLocation = view.bounds.size.height - sender.location(in: view).y - groundView.bounds.height
        heightIndicatorYConstraint.constant = yLocation
        view.layoutIfNeeded()
        
        let availableHeight = astronautView.frame.minY - heightLabel.frame.maxY
        let progress = (yLocation - astronautView.frame.height) / availableHeight
        let height = max(min(maxJumpHeight, Int(CGFloat(maxJumpHeight) * progress)), 0)
        selectedHeight = Int(5.0 * floor(Double(height)/5.0) + 0.5)
        heightLabel.text = "\(selectedHeight) ft"
        
        
        // Reset state when ever selected height changes
        heightLabel.textColor = UIColor.white
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .beginFromCurrentState, animations: {
            self.astronautView.transform = CGAffineTransform.init(translationX: 0.0, y: 0.0)
        }, completion: nil)
    }
    
}
