//
//  TestHelpers.swift
//  Solar System Mac Unit Tests
//
//  Created by Administrator on 4/17/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

func testSleep(_ miliseconds: UInt32) {
    
    var wakeUp = false
    
    DispatchQueue.global(qos: .background).async {
        let napTime = (miliseconds / 1000) + arc4random_uniform(1)
        sleep(napTime)
        DispatchQueue.main.async {
            wakeUp = true
        }
    }
    
    let runLoop = RunLoop.current
    while (!wakeUp && runLoop.run(mode: .defaultRunLoopMode, before: .distantFuture)) {
        
    }
    
}
