//
//  CircleView.swift
//  Science
//
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit

@IBDesignable
class CircleView: UIView {
    
    @IBInspectable var strokeWidth: CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var strokeColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let ovalPath = UIBezierPath.init(ovalIn: CGRect(x: strokeWidth/2.0, y: strokeWidth/2.0, width: rect.width-strokeWidth, height: rect.width-strokeWidth))
        strokeColor.setStroke()
        ovalPath.lineWidth = strokeWidth
        ovalPath.stroke()
    }
    
}
