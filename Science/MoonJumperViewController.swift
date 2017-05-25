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
let minAccellerationForJumpAnimation = 10.5

class MoonJumperViewController: UIViewController {
    
    @IBOutlet weak var groundView: UIView!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightCircleView: CircleView!
    @IBOutlet weak var heightIndicatorView: UIView!
    @IBOutlet weak var heightIndicatorYConstraint: NSLayoutConstraint!
    @IBOutlet weak var astronautView: UIView!
    
    let manager = CMMotionManager()
    var selectedHeight = 180 // ft
    var didReachSelectedHeight = false
    
    var animator: UIDynamicAnimator?
    let gravity = UIGravityBehavior()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Monitor motion
        manager.deviceMotionUpdateInterval = 0.05
        if manager.isDeviceMotionAvailable {
            
            manager.startDeviceMotionUpdates(to: .main, withHandler: { [weak self] (deviceMotion, error) in
                let userAcceleration = deviceMotion!.userAcceleration
                let gravity = userAcceleration.y + 1.0 * 9.81
                
                let selectedHeight = Double(self!.selectedHeight)
                let requiredAcceleration = 10 + selectedHeight / requiredAccellerationScaleFactor
                
                if gravity > requiredAcceleration {
                    self?.didReachSelectedHeight = true
                    self?.heightLabel.textColor = UIColor.green
                    self?.heightCircleView.strokeColor = UIColor.green
                    
                    DispatchQueue.main.async {
                        self?.reachedSelectedHeight()
                    }
                }
                else if self?.didReachSelectedHeight == false && gravity > minAccellerationForJumpAnimation {
                    UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseInOut, .beginFromCurrentState], animations: {
                        self?.astronautView.transform = CGAffineTransform.init(translationX: 0.0, y: -50.0)
                    }, completion: { (completed) in
                        if self?.didReachSelectedHeight == false {
                            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: .beginFromCurrentState, animations: {
                                self?.astronautView.transform = CGAffineTransform.init(translationX: 0.0, y: 0.0)
                            }, completion: nil)
                        }
                    })
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
        
        let availableHeight = astronautView.frame.minY - heightCircleView.frame.maxY
        let progress = (yLocation - astronautView.frame.height) / availableHeight
        let height = max(min(maxJumpHeight, Int(CGFloat(maxJumpHeight) * progress)), 0)
        selectedHeight = Int(5.0 * floor(Double(height)/5.0) + 0.5)
        heightLabel.text = "\(selectedHeight) ft"
        
        
        // Reset state when ever selected height changes
        didReachSelectedHeight = false
        heightLabel.textColor = UIColor.white
        heightCircleView.strokeColor = UIColor.init(white: 0.4, alpha: 1.0)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .beginFromCurrentState, animations: {
            self.astronautView.transform = CGAffineTransform.init(translationX: 0.0, y: 0.0)
        }, completion: nil)
    }
    
}
