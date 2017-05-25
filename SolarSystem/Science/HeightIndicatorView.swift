//
//  HeightIndicatorView.swift
//  Science
//
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit

@IBDesignable
class HeightIndicatorView: UIView {
    
    override func draw(_ rect: CGRect) {
        //// Color Declarations
        let color = UIColor.init(white: 0.4, alpha: 1.0)
        
        //// Rectangle Drawing
        let lineWidth: CGFloat = 2.0
        let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: rect.midY - lineWidth/2.0, width: rect.width, height: lineWidth))
        color.setFill()
        rectanglePath.fill()
        
        let arrowWidth: CGFloat = 6.0
        
        //// LeftArrowGray Drawing
        let leftArrowGrayPath = UIBezierPath()
        leftArrowGrayPath.move(to: CGPoint(x: 0, y: 0))
        leftArrowGrayPath.addLine(to: CGPoint(x: arrowWidth, y: rect.height / 2.0))
        leftArrowGrayPath.addLine(to: CGPoint(x: 0, y: rect.height))
        leftArrowGrayPath.close()
        color.setFill()
        leftArrowGrayPath.fill()
        
        //// RightArrowGray Drawing
        let rightArrowGrayPath = UIBezierPath()
        rightArrowGrayPath.move(to: CGPoint(x: rect.width, y: 0))
        rightArrowGrayPath.addLine(to: CGPoint(x: rect.width-arrowWidth, y: rect.height / 2.0))
        rightArrowGrayPath.addLine(to: CGPoint(x: rect.width, y: rect.height))
        rightArrowGrayPath.close()
        color.setFill()
        rightArrowGrayPath.fill()
    }
    
}
