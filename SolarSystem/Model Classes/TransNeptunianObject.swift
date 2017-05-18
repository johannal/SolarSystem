//
//  TransNeptunianObject.swift
//  Science
//
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

// DEMO: Rename across multipe files and types
public class TransNeptunianObject: NSObject {
    
    public let name: String
    
    public let shape: Shape
    
    public enum Shape {
        case spherical
        case oblong
        case irregular
    }
    
    public init(name: String, shape: Shape) {
        self.name = name
        self.shape = shape
    }
    
}
