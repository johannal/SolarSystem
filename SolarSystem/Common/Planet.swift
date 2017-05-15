//
//  Planet.swift
//  Science
//
//  Created by Ken Orr on 5/15/17.
//  Copyright © 2017 Debugger UI. All rights reserved.
//

import UIKit

public protocol Planet {
    
    var name: String { get }
    
    var color: UIColor { get }
    
    var moons: [Moon] { get }
}
