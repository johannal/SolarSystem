//
//  GravityMeterViewController.swift
//  Science
//
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import CoreMotion

let criticalGravityForHumans = 13.0

class GravityMeterViewController: UIViewController {
    
    @IBOutlet weak var gravityLabel: UILabel!
    
    let manager = CMMotionManager()
    var maxGravity = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.green
        
        // Monitor motion
        manager.deviceMotionUpdateInterval = 0.05
        if manager.isDeviceMotionAvailable {
            
            manager.startDeviceMotionUpdates(to: .main, withHandler: { [weak self] (deviceMotion, error) in
                let userAcceleration = deviceMotion!.userAcceleration
                let gravity = userAcceleration.y + 1.0 * 9.81
                
                if let maxGravity = self?.maxGravity {
                    if gravity > maxGravity {
                        self!.maxGravity = gravity
                        self?.gravityLabel.text = String(format: "%.2f m/s²", gravity)
                        
                        if gravity > criticalGravityForHumans {
                            // Update UI
                            self?.view.backgroundColor = UIColor.red
                            
                            DispatchQueue.main.async {
                                self?.criticalGravityDetected()
                            }
                        }
                    }
                }
            })
        }
    }
    
    func criticalGravityDetected() {
        // TODO: Inform user about consequences
        print("😱")
    }
    
}
