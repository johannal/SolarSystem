//
//  Planet.swift
//  Science
//
//  Copyright © 2017. All rights reserved.
//

import UIKit

public protocol Planet {
    
    var name: String { get }
    
    var color: UIColor { get }
    
    var moons: [Moon] { get }
}
