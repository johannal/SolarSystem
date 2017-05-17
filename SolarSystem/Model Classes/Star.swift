//
//  Sun.swift
//  Science
//
//  Copyright © 2017. All rights reserved.
//

import UIKit

public class Star {
    
    let name: String
    
    let color: UIColor
    
    private(set) var planets: [Planet] = []
    
    public init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
}
