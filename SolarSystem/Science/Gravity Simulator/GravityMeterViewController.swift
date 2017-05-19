//
//  GravityMeterViewController.swift
//  Science
//
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import CoreMotion

class GravityMeterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = CMMotionManager()
        
        manager.startDeviceMotionUpdates(to: OperationQueue()) { deviceMotion, error in
            let gravity = deviceMotion!.gravity
            print("Gravity x: \(gravity.x) y: \(gravity.x) z: \(gravity.x)")
        }
        
//        manager.startAccelerometerUpdates(to: .main) {
//            [weak self] (data: CMAccelerometerData?, error: Error?) in
//            if let acceleration = data?.acceleration {
//                let rotation = atan2(acceleration.x, acceleration.y) - M_PI
//            }
//        }
    }

}
