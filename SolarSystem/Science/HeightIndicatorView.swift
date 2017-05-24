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
        let fillColor = UIColor.yellow
        let strokeColor2 = UIColor.white
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRect(x: rect.minX + 5, y: rect.minY + 7, width: rect.width - 11, height: 2))
        strokeColor2.setFill()
        rectanglePath.fill()
        
        //// LeftArrowGray Drawing
        let leftArrowGrayPath = UIBezierPath()
        leftArrowGrayPath.move(to: CGPoint(x: rect.minX, y: rect.minY + 2.99))
        leftArrowGrayPath.addCurve(to: CGPoint(x: rect.minX + 3.58, y: rect.minY + 0.79), controlPoint1: CGPoint(x: rect.minX, y: rect.minY + 0.79), controlPoint2: CGPoint(x: rect.minX + 1.6, y: rect.minY - 0.2))
        leftArrowGrayPath.addLine(to: CGPoint(x: rect.minX + 14.42, y: rect.minY + 6.21))
        leftArrowGrayPath.addCurve(to: CGPoint(x: rect.minX + 14.42, y: rect.minY + 9.79), controlPoint1: CGPoint(x: rect.minX + 16.4, y: rect.minY + 7.2), controlPoint2: CGPoint(x: rect.minX + 16.4, y: rect.minY + 8.8))
        leftArrowGrayPath.addLine(to: CGPoint(x: rect.minX + 3.58, y: rect.minY + 15.21))
        leftArrowGrayPath.addCurve(to: CGPoint(x: rect.minX, y: rect.minY + 13.01), controlPoint1: CGPoint(x: rect.minX + 1.6, y: rect.minY + 16.2), controlPoint2: CGPoint(x: rect.minX, y: rect.minY + 15.21))
        leftArrowGrayPath.addLine(to: CGPoint(x: rect.minX, y: rect.minY + 2.99))
        leftArrowGrayPath.close()
        fillColor.setFill()
        leftArrowGrayPath.fill()
        
        //// RightArrowGray Drawing
        let rightArrowGrayPath = UIBezierPath()
        rightArrowGrayPath.move(to: CGPoint(x: rect.maxX, y: rect.minY + 2.99))
        rightArrowGrayPath.addCurve(to: CGPoint(x: rect.maxX - 3.58, y: rect.minY + 0.79), controlPoint1: CGPoint(x: rect.maxX, y: rect.minY + 0.79), controlPoint2: CGPoint(x: rect.maxX - 1.6, y: rect.minY - 0.2))
        rightArrowGrayPath.addLine(to: CGPoint(x: rect.maxX - 14.42, y: rect.minY + 6.21))
        rightArrowGrayPath.addCurve(to: CGPoint(x: rect.maxX - 14.42, y: rect.minY + 9.79), controlPoint1: CGPoint(x: rect.maxX - 16.4, y: rect.minY + 7.2), controlPoint2: CGPoint(x: rect.maxX - 16.4, y: rect.minY + 8.8))
        rightArrowGrayPath.addLine(to: CGPoint(x: rect.maxX - 3.58, y: rect.minY + 15.21))
        rightArrowGrayPath.addCurve(to: CGPoint(x: rect.maxX, y: rect.minY + 13.01), controlPoint1: CGPoint(x: rect.maxX - 1.6, y: rect.minY + 16.2), controlPoint2: CGPoint(x: rect.maxX, y: rect.minY + 15.21))
        rightArrowGrayPath.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + 2.99))
        rightArrowGrayPath.close()
        fillColor.setFill()
        rightArrowGrayPath.fill()
    }
    
}
