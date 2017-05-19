//
//  SolarSystemView.swift
//  Science
//
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

// TODO (ken orr): make this file have a TON of code (multiple thousands of lines).

public class SolarSystemView: UIView {
    
    // Solar colors, coldest to hottest.
    let solarBlack = #colorLiteral(red: 0.1501053572, green: 0.003685685573, blue: 0, alpha: 1)
    let solarOrangeCold = #colorLiteral(red: 0.6025915742, green: 0.06830655783, blue: 0.008578506298, alpha: 1)
    let solarOrangeCool = #colorLiteral(red: 0.8073487878, green: 0.1142350063, blue: 0.002793580992, alpha: 1)
    let solarOrangeWarm = #colorLiteral(red: 0.9957380891, green: 0.55527246, blue: 0.00718178181, alpha: 1)
    let solarOrangeHot  = #colorLiteral(red: 0.9369437695, green: 0.9170747995, blue: 0.8956354856, alpha: 1)
    
}

private let PresentationPaddingPercent = 0.10

public struct Bounds {
    public var minX: Double
    public var maxX: Double
    public var minY: Double
    public var maxY: Double
    
    static let infinite = Bounds(minX: .infinity, maxX: .infinity, minY: .infinity, maxY: .infinity)
}

internal extension Bounds {
    func contains(data: (Double, Double)) -> Bool {
        if data.0 < minX { return false }
        if data.0 > maxX { return false }
        if data.1 < minY { return false }
        if data.1 > maxY { return false }
        return true
    }
}

internal struct Insets {
    internal var top = 0.0
    internal var left = 0.0
    internal var bottom = 0.0
    internal var right = 0.0
}

private let BottomPadForStopButton = 90.0
private let BottomInsetThreshold = 100.0

extension Bounds: Equatable {}

public func ==(left: Bounds, right: Bounds) -> Bool {
    return left.minX == right.minX && left.maxX == right.maxX && left.minY == right.minY && left.maxY == right.maxY
}

extension Bounds {
    
    internal var deltaX: Double {
        get {
            return maxX - minX
        }
    }
    
    internal var deltaY: Double {
        get {
            return maxY - minY
        }
    }
    
    internal var midX: Double {
        get {
            return minX + ((maxX - minX) / 2)
        }
    }
    internal var midY: Double {
        get {
            return minY + ((maxY - minY) / 2)
        }
    }
    
    public var isEmpty: Bool {
        get {
            return deltaX == 0 && deltaY == 0
        }
    }
    
    internal func containsPoint(point: CGPoint) -> Bool {
        return (Double(point.x) >= minX) && (Double(point.x) <= maxX) && (Double(point.y) <= minY) && (Double(point.y) <= minY)
    }
    
    internal func adjustedByScale(scale: Double, from anchor: CGPoint) -> Bounds {
        var newBounds = self
        
        let xMultiplier = (Double(anchor.x) - minX) / deltaX
        let yMultiplier = (Double(anchor.y) - minY) / deltaY
        
        let xDeltaChange = deltaX - (deltaX / scale)
        let yDeltaChange = deltaY - (deltaY / scale)
        
        newBounds.minX += xDeltaChange * xMultiplier
        newBounds.maxX -= xDeltaChange * (1.0 - xMultiplier)
        newBounds.minY += yDeltaChange * yMultiplier
        newBounds.maxY -= yDeltaChange * (1.0 - yMultiplier)
        
        return newBounds
    }
    
    internal func adjustedByPositionPoint(point: CGPoint, multiplier: CGPoint = CGPoint(x: 1.0, y: 1.0)) -> Bounds {
        var newBounds = self
        newBounds.maxX -= Double(multiplier.x * point.x)
        newBounds.minX -= Double(multiplier.x * point.x)
        newBounds.maxY += Double(multiplier.y * point.y)
        newBounds.minY += Double(multiplier.y * point.y)
        
        return newBounds
    }
    
    /// Unions this Bounds with the other Bounds, favoring values that are not infinity.
    internal func unionIgnorningInfinity(_ otherBounds: Bounds) -> Bounds {
        let newMinX = minIgnoringInfinity(minX, otherBounds.minX)
        let newMaxX = maxIgnoringInfinity(maxX, otherBounds.maxX)
        let newMinY = minIgnoringInfinity(minY, otherBounds.minY)
        let newMaxY = maxIgnoringInfinity(maxY, otherBounds.maxY)
        
        return Bounds(minX: newMinX, maxX: newMaxX, minY: newMinY, maxY: newMaxY)
    }
    
    private func minIgnoringInfinity(_ a: Double, _ b: Double) -> Double {
        let minValue: Double
        if (a == .infinity) {
            minValue = b
        } else if (b == .infinity) {
            minValue = a
        } else {
            minValue = min(a, b)
        }
        
        return minValue
    }
    
    private func maxIgnoringInfinity(_ a: Double, _ b: Double) -> Double {
        let maxValue: Double
        if (a == .infinity) {
            maxValue = b
        } else if (b == .infinity) {
            maxValue = a
        } else {
            maxValue = max(a, b)
        }
        
        return maxValue
    }
}

extension CGRect {
    mutating func insetWithEdgeInsets(insets: UIEdgeInsets) {
        origin.x += insets.left
        origin.y += insets.bottom
        size.width -= insets.left + insets.right
        size.height -= insets.top + insets.bottom
    }
    
    func rectByInsettingRectWithEdgeInsets(insets: Insets) -> CGRect {
        var rect = self
        
        rect.origin.x += CGFloat(insets.left)
        rect.origin.y += CGFloat(insets.bottom)
        rect.size.width -= CGFloat(insets.left + insets.right)
        rect.size.height -= CGFloat(insets.top + insets.bottom)
        
        return rect
    }
}

public class Color: _ExpressibleByColorLiteral {
    
    internal let uiColor: UIColor
    
    internal var cgColor: CGColor {
        return uiColor.cgColor
    }
    
    public static let clear: Color = #colorLiteral(red: 1, green: 0.9999743700027466, blue: 0.9999912977218628, alpha: 0)
    
    public static let white: Color = #colorLiteral(red: 1, green: 0.9999743700027466, blue: 0.9999912977218628, alpha: 1)
    public static let gray: Color = #colorLiteral(red: 0.3367644548, green: 0.3980174661, blue: 0.4406478703, alpha: 1)
    public static let black: Color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    public static let purple: Color = #colorLiteral(red: 0.2666243911, green: 0.1584459841, blue: 0.7177972794, alpha: 1)
    public static let pink: Color = #colorLiteral(red: 0.7086744905, green: 0.05744680017, blue: 0.5434997678, alpha: 1)
    public static let green: Color = #colorLiteral(red: 0.07005243003, green: 0.5545874834, blue: 0.1694306433, alpha: 1)
    public static let blue: Color = #colorLiteral(red: 0, green: 0.1771291047, blue: 0.97898072, alpha: 1)
    
    public init(white: CGFloat, alpha: CGFloat = 1.0) {
        if 0 <= white && white <= 1.0 {
            // valid white, no adjustment necessary.
        }
        uiColor = UIColor(white: white, alpha: alpha)
    }
    
    public init(hue: Double, saturation: Double, brightness: Double, alpha: Double = 1.0) {
        uiColor = UIColor(hue: CGFloat(hue), saturation: CGFloat(saturation), brightness: CGFloat(brightness), alpha: CGFloat(alpha))
    }
    
    public init(red: Double, green: Double, blue: Double, alpha: Double = 1.0) {
        uiColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }
    
    internal init(_ uiColor: UIColor) {
        self.uiColor = uiColor
    }
    
    public convenience required init(colorLiteralRed red: Float, green: Float, blue: Float, alpha: Float) {
        self.init(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
    }
    
    public func lighter(percent: Double = 0.2) -> Color {
        return colorByAdjustingBrightness(percent: 1 + percent)
    }
    
    public func withAlpha(alpha: Double) -> Color {
        return Color(uiColor.withAlphaComponent(CGFloat(alpha)))
    }
    
    public func darker(percent: Double = 0.2) -> Color {
        return colorByAdjustingBrightness(percent: 1 - percent)
    }
    
    private func colorByAdjustingBrightness(percent: Double) -> Color {
        var cappedPercent = min(percent, 1.0)
        cappedPercent = max(0.0, percent)
        
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        self.uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        return Color(hue: Double(hue), saturation: Double(saturation), brightness: Double(brightness) * cappedPercent, alpha: Double(alpha))
    }
    
    public static func random() -> Color {
        let uint32MaxAsFloat = Float(UInt32.max)
        let red = Float(arc4random()) / uint32MaxAsFloat
        let blue = Float(arc4random()) / uint32MaxAsFloat
        let green = Float(arc4random()) / uint32MaxAsFloat
        
        return Color(red: Double(red), green: Double(green), blue: Double(blue), alpha: 1.0)
    }
    
    private static let standard = [purple, pink, green, blue, gray]
    
    private static var currentColorIndex = 0
    
    internal static func next() -> Color {
        let colorToReturn = standard[currentColorIndex]
        if (currentColorIndex == standard.count - 1) {
            currentColorIndex = 0
        } else {
            currentColorIndex += 1
        }
        
        return colorToReturn
    }
    
    internal static func resetCurrentColor() {
        currentColorIndex = 0
    }
}
