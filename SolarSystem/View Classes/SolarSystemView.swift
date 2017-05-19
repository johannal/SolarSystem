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

private let _quarterTurn = Measurement<UnitAngle>(value: 90, unit: .degrees)

public extension Measurement where UnitType == UnitAngle {
    /// True if the cumulative rotation leaves the rotation at 90° or 270° equivalents
    /// (0° is assumed to be portrait)
    public var isLandscape: Bool {
        let absoluteDegrees = abs(self.degrees)
        return absoluteDegrees.isAlmost(90) || absoluteDegrees.isAlmost(270)
    }
    
    public enum Orientation {
        case portrait
        case landscapeLeft
        case landscapeRight
        case portraitUpsidedown
    }
    
    public var orientationEquivalent: Orientation {
        let degrees = self.degrees
        if degrees.isAlmost(90) || degrees.isAlmost(-270) {
            return .landscapeLeft
        } else if degrees.isAlmost(-90) || degrees.isAlmost(270) {
            return .landscapeRight
        } else if degrees.isAlmost(-180) || degrees.isAlmost(180) {
            return .portraitUpsidedown
        } else {
            return .portrait
        }
    }
    
    public var degrees: CGFloat {
        return CGFloat(self.converted(to: UnitAngle.degrees).value.truncatingRemainder(dividingBy: 360))
    }
    
    public var radians: CGFloat {
        return CGFloat(self.converted(to: UnitAngle.radians).value)
    }
    
    /// Returns the result of rotating self a quarter turn anti-clockwise
    public func rotatedLeft() -> Measurement {
        return self + _quarterTurn
    }
    
    /// Rotates self a quarter turn anti-clockwise
    public mutating func rotateLeft() {
        self = self.rotatedLeft()
    }
    
    /// Returns the result of rotating self a quarter turn clockwise
    public func rotatedRight() -> Measurement {
        return self - _quarterTurn
    }
    
    /// Rotates self a quarter turn clockwise
    public mutating func rotateRight() {
        self = self.rotatedRight()
    }
    
    public static prefix func - (value: Measurement) -> Measurement {
        return Measurement(value: -value.value, unit: value.unit)
    }
    
    public static func + (lhs: Measurement, rhs: Measurement) -> Measurement {
        let lhsDegrees = lhs.unit == .degrees ? lhs : lhs.converted(to: .degrees)
        let rhsDegrees = rhs.unit == .degrees ? rhs : rhs.converted(to: .degrees)
        return Measurement(value: lhsDegrees.value + rhsDegrees.value, unit: .degrees)
    }
    
    public static func - (lhs: Measurement, rhs: Measurement) -> Measurement {
        return lhs + (-rhs)
    }
}

public extension CGFloat {
    func isAlmost(_ value: CGFloat, precision: CGFloat = 0.001) -> Bool {
        let (myInt, myFrac) = modf(self)
        let (otherInt, otherFrac) = modf(value)
        if myInt != otherInt {
            return false
        }
        let diff = Swift.max(myFrac, otherFrac) - Swift.min(myFrac, otherFrac)
        
        return diff < precision
    }
}

protocol OptionalType: ExpressibleByNilLiteral { }

// Optional already has an ExpressibleByNilLiteral conformance
// so we just adopt the protocol
extension Optional: OptionalType { }

extension Optional where Wrapped: OptionalType {
    func flatten() -> Wrapped {
        switch self {
        case let .some(value):
            return value
        case .none:
            return nil
        }
    }
    
    var descriptionOrEmpty: String {
        return self.flatMap(String.init(describing:)) ?? ""
    }
    
    var descriptionOrNil: String {
        return self.flatMap(String.init(describing:)) ?? "(nil)"
    }
}

protocol _CollectionOrStringish {
    var isEmpty: Bool { get }
}

extension String: _CollectionOrStringish { }
extension Array: _CollectionOrStringish { }
extension Dictionary: _CollectionOrStringish { }
extension Set: _CollectionOrStringish { }

extension Optional where Wrapped: _CollectionOrStringish {
    var isNilOrEmpty: Bool {
        switch self {
        case let .some(value): return value.isEmpty
        default: return true
        }
    }
}

public extension DispatchQueue {
    /// Convenience function to execute a synchronous barrier block
    ///
    /// - Parameter block: the block
    public func syncBarrier(_ block: @escaping @convention(block) () -> Void) {
        self.sync(execute: DispatchWorkItem(flags: .barrier, block: block))
    }
    
    /// Convenience function to execute an asynchronous barrier block
    ///
    /// - Parameter block: the block
    public func asyncBarrier(_ block: @escaping @convention(block) () -> Void) {
        self.async(execute: DispatchWorkItem(flags: .barrier, block: block))
    }
    
    /// Assert that execution is on the given queue
    ///
    /// - Parameter queue: The queue
    public static func assert(on queue: DispatchQueue) {
        if #available(OSX 10.12, *) {
            dispatchPrecondition(condition: DispatchPredicate.onQueue(queue))
        }
    }
}

public extension CGFloat {
    
    /// Rounds to the nearest 0.5:
    ///
    ///  1.12 -> 1.0
    ///  1.45 -> 1.5
    ///  1.79 -> 2.0
    ///
    /// - Returns: The rounded value
    func halfPointRounded() -> CGFloat {
        let (integer, fractional) = modf(self)
        if fractional < 0.26 {
            return integer
        } else if fractional < 0.76 {
            return integer + 0.5
        } else {
            return integer + 1.0
        }
    }
}

public extension CGSize {
    static let unit = CGSize(width: 1, height: 1)
    
    /// Swap width and height
    func transposed() -> CGSize {
        return CGSize(width: self.height, height: self.width)
    }
    
    func halfPointRounded() -> CGSize {
        return CGSize(width: self.width.halfPointRounded(), height: self.height.halfPointRounded())
    }
    func rounded() -> CGSize {
        return CGSize(width: Int(self.width), height: Int(self.height))
    }
    
    static func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
    }
    
    static func * (lhs: CGFloat, rhs: CGSize) -> CGSize {
        return rhs * lhs
    }
    
    static func / (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width / rhs, height: lhs.height / rhs)
    }
    
    static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
    
    static func + (lhs: CGSize, rhs: UIEdgeInsets) -> CGSize {
        return CGSize(width: lhs.width + rhs.left + rhs.right, height: lhs.height + rhs.top + rhs.bottom)
    }
    
    static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }
    
    static prefix func - (value: CGSize) -> CGSize {
        return CGSize(width: -value.width, height: -value.height)
    }
    
    static func + (lhs: CGSize, rhs: LengthDimension) -> CGSize {
        switch rhs {
        case let .width(w):
            return CGSize(width: lhs.width + w, height: lhs.height)
        case let .height(h):
            return CGSize(width: lhs.width, height: lhs.height + h)
        }
    }
    
    static func - (lhs: CGSize, rhs: LengthDimension) -> CGSize {
        return lhs + (-rhs)
    }
    
}


public extension CGPoint {
    func clamped(minX: CGFloat = 0, minY: CGFloat = 0, maxX: CGFloat = 1.0, maxY: CGFloat = 1.0) -> CGPoint {
        var copy = self
        copy.clamp()
        return copy
    }
    
    mutating func clamp(minX: CGFloat = 0, minY: CGFloat = 0, maxX: CGFloat = 1.0, maxY: CGFloat = 1.0) {
        x = max(min(self.x, maxX), minX)
        y = max(min(self.y, maxY), minY)
    }
    
    func rotate(by rotation: Measurement<UnitAngle>, inCoordinateSystem coord: CGRect) -> CGPoint {
        switch rotation.orientationEquivalent {
        case .portrait:
            return self
        case .landscapeRight:
            return CGPoint(x: self.y, y: coord.width - self.x)
        case .landscapeLeft:
            return CGPoint(x: coord.height - self.y, y: self.x)
        case .portraitUpsidedown:
            return CGPoint(x: coord.width - self.x, y: coord.height - self.y)
        }
    }
    
    static func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }
    
    static func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
    }
    
    static func + (lhs: CGPoint, rhs: AxisDimension) -> CGPoint {
        switch rhs {
        case let .x(x):
            return CGPoint(x: lhs.x + x, y: lhs.y)
        case let .y(y):
            return CGPoint(x: lhs.x, y: lhs.y + y)
        }
    }
    
    static func - (lhs: CGPoint, rhs: AxisDimension) -> CGPoint {
        return lhs + (-rhs)
    }
    
    static prefix func - (value: CGPoint) -> CGPoint {
        return CGPoint(x: -value.x, y: -value.y)
    }
    
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
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


public enum AxisDimension {
    case x(CGFloat)
    case y(CGFloat)
    
    static prefix func - (value: AxisDimension) -> AxisDimension {
        switch value {
        case let .x(x):
            return .x(-x)
        case let .y(y):
            return .y(-y)
        }
    }
}

public enum LengthDimension {
    case width(CGFloat)
    case height(CGFloat)
    
    static prefix func - (value: LengthDimension) -> LengthDimension {
        switch value {
        case let .width(w):
            return .width(-w)
        case let .height(h):
            return .height(-h)
        }
    }
}

public extension CGRect {
    static let unit = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
    
    init(size: CGSize, centeredInside rect: CGRect) {
        self.init(
            x: ((rect.width - size.width) / 2) + rect.origin.x,
            y: ((rect.height - size.height) / 2) + rect.origin.y,
            width: size.width,
            height: size.height
        )
    }
    
    /// Rotates the rect within a given coordinate system
    ///
    /// - Parameter rotation: The angle to rotate. Quarter turns only, positive values are counter-clockwise.
    /// - Parameter coord: The coordinate system against which to rotate
    /// - Returns: The rotated rectangle
    func rotate(by rotation: Measurement<UnitAngle>, inCoordinateSystem coord: CGRect) -> CGRect {
        let convertPoint = rotation.pointMap(size: coord.size)
        let p1 = convertPoint(CGPoint(x: self.minX, y: self.minY))
        let p2 = convertPoint(CGPoint(x: self.maxX, y: self.maxY))
        
        let newOrigin = CGPoint(x: min(p1.x, p2.x), y: min(p1.y, p2.y))
        let maxX = max(p1.x, p2.x)
        let maxY = max(p1.y, p2.y)
        let newSize = CGSize(width: maxX - newOrigin.x, height: maxY - newOrigin.y)
        return CGRect(origin: newOrigin, size: newSize)
    }
    
    static func + (lhs: CGRect, rhs: AxisDimension) -> CGRect {
        return CGRect(origin: lhs.origin + rhs, size: lhs.size)
    }
    
    static func - (lhs: CGRect, rhs: AxisDimension) -> CGRect {
        return CGRect(origin: lhs.origin - rhs, size: lhs.size)
    }
    
    static func + (lhs: CGRect, rhs: LengthDimension) -> CGRect {
        return CGRect(origin: lhs.origin, size: lhs.size + rhs)
    }
    
    static func - (lhs: CGRect, rhs: LengthDimension) -> CGRect {
        return CGRect(origin: lhs.origin, size: lhs.size - rhs)
    }
    
    /// Adding insets expands the rect
    static func + (lhs: CGRect, rhs: UIEdgeInsets) -> CGRect {
        let newOrigin = lhs.origin - .x(rhs.left) - .y(rhs.bottom)
        let newSize = lhs.size + CGSize(width: rhs.left + rhs.right, height: rhs.bottom + rhs.top)
        return CGRect(origin: newOrigin, size: newSize)
    }
    
    /// Subtracting insets shrinks the rect
    static func - (lhs: CGRect, rhs: UIEdgeInsets) -> CGRect {
        let newOrigin = lhs.origin + .x(rhs.left) + .y(rhs.bottom)
        let newSize = lhs.size - CGSize(width: rhs.left + rhs.right, height: rhs.bottom + rhs.top)
        return CGRect(origin: newOrigin, size: newSize)
    }
}

extension Measurement where UnitType == UnitAngle {
    fileprivate func  pointMap(size: CGSize) -> (CGPoint) -> CGPoint {
        let (integerPart, _) = modf(self.converted(to: .degrees).value.truncatingRemainder(dividingBy: 360))
        switch integerPart {
        case 0:
            return { $0 }
        case 90, -270:
            return { CGPoint(x: size.height - $0.y, y: $0.x) }
        case 180, -180:
            return { CGPoint(x: size.width - $0.x, y: size.height - $0.y) }
        case 270, -90:
            return { CGPoint(x: $0.y, y: size.width - $0.x) }
        default:
            fatalError("Only quarter-turn rotations are supported (0, 90, 180, 270)")
        }
    }
}

/// The equivalent of Objective-C's `@synchronized`
///
/// - Parameters:
///   - obj: The object
///   - execute: The function to execute while holding the lock
public func lock<T>(_ obj: AnyObject, execute: () throws -> T) rethrows -> T {
    objc_sync_enter(obj)
    defer { objc_sync_exit(obj) }
    return try execute()
}

/// Queues up any number of async execution blocks.
/// Any errors are collected and thrown when `waitForCompletion` is called
/// or when the `notifyOnCompletion` block runs.
public class AsyncGroup {
    public struct AsyncError: Error, CustomNSError {
        public let errors: [Error]
        public var errorCode: Int { return 1 }
        public var errorDomain: String { return "com.apple.SimulatorKit.AsyncGroup" }
        public var errorUserInfo: [String : Any] {
            return [
                NSLocalizedDescriptionKey: "\(errors.count) error(s) were generated. First error was: \(errors[0].localizedDescription)",
                "AllErrors": errors
            ]
        }
    }
    
    private let _queue: DispatchQueue
    private let _group: DispatchGroup
    private var _errors: [Error] = []
    private var _lock = NSObject()
    
    /// Creates a new AsyncGroup
    ///
    /// - Parameters:
    ///   - queue: The queue to execute on
    ///   - group: (Optional) An existing group to use. Defaults to a new group.
    public init(queue: DispatchQueue, group: DispatchGroup = DispatchGroup()) {
        self._queue = queue
        self._group = group
    }
    
    /// Executes the function async on the queue. Thrown errors are collected.
    ///
    /// - Parameter execute: The function to execute
    public func async(_ execute: @escaping () throws -> Void) {
        _queue.async(group: _group) {
            do {
                try execute()
            } catch {
                lock(self._lock) {
                    self._errors.append(error)
                }
            }
        }
    }
    
    /// Submits a function to execute when the group finishes executing all async work
    ///
    /// - Parameter execute: The function to execute. Receives an AsyncError if any async
    ///     functions threw an error, otherwise nil.
    public func notifyOnCompletion(_ execute: @escaping (Error?) -> Void) {
        _group.notify(queue: _queue, work: DispatchWorkItem(block: {
            if !self._errors.isEmpty {
                execute(AsyncError(errors: self._errors))
            } else {
                execute(nil)
            }
        }))
    }
    
    /// Blocks waiting for all submitted async work to complete.
    ///
    /// - Parameter timeout: The wait timeout; defaults to forever
    /// - Throws: AsyncError if any of the async work functions threw an error, otherwise will not throw.
    @discardableResult
    public func waitForCompletion(timeout: DispatchTime = DispatchTime.distantFuture) throws -> DispatchTimeoutResult {
        let result = _group.wait(timeout: timeout)
        if !self._errors.isEmpty {
            throw AsyncError(errors: _errors)
        }
        return result
    }
}

/// Wraps the libDispatch reader-writer lock pattern
///
/// - Warning: allowing a reference type to escape the
/// read or write functions is undefined behavior.
public final class ReaderWriterLock<Value> {
    private let _lock: DispatchQueue
    private var _value: Value
    
    public init(value: Value, name: String? = nil, qos: DispatchQoS = .default) {
        _value = value
        _lock = DispatchQueue(label: name ?? UUID().uuidString, qos: qos, attributes: [.concurrent])
    }
    
    public func readAsync(reader: @escaping (Value) -> Void) {
        _lock.async {
            reader(self._value)
        }
    }
    
    public func readSync<Result>(reader: (Value) throws -> Result) rethrows -> Result {
        return try _lock.sync {
            return try reader(self._value)
        }
    }
    
    public func writeAsync(writer: @escaping (Value) -> Value) {
        _lock.asyncBarrier {
            self._value = writer(self._value)
        }
    }
    
    public func writeSync(writer: @escaping (Value) -> Value) {
        _lock.syncBarrier {
            self._value = writer(self._value)
        }
    }
}

private let _timebase: mach_timebase_info = {
    var timebase = mach_timebase_info()
    mach_timebase_info(&timebase)
    return timebase
}()

public struct MachTime: Comparable, CustomStringConvertible {
    public static var current: MachTime {
        return MachTime()
    }
    
    private let _time: UInt64
    
    private init() {
        _time = mach_absolute_time()
    }
    
    /// Seconds
    public var seconds: TimeInterval {
        let ns = Double(nanoseconds)
        return ns / Double(NSEC_PER_SEC)
    }
    
    /// Milliseconds (ms): 1/1000 of a second
    public var milliseconds: UInt64 {
        return nanoseconds / NSEC_PER_MSEC
    }
    
    /// Microseconds (µs or us): 1/1,000,000 of a second
    public var microseconds: UInt64 {
        return nanoseconds / NSEC_PER_USEC
    }
    
    /// Nanoseconds (ns): 1/1,000,000,000 of a second
    public var nanoseconds: UInt64 {
        return _time * UInt64(_timebase.numer) / UInt64(_timebase.denom)
    }
    
    public var description: String {
        if seconds > 10 {
            return "\(seconds) seconds"
        } else if milliseconds > 10 {
            return "\(milliseconds)ms"
        } else if microseconds > 10 {
            return "\(microseconds)µs"
        } else {
            return "\(nanoseconds)ns"
        }
    }
    
    public var hashValue: Int {
        return _time.hashValue
    }
    
    public static func == (lhs: MachTime, rhs: MachTime) -> Bool {
        return lhs._time == rhs._time
    }
    
    public static func < (lhs: MachTime, rhs: MachTime) -> Bool {
        return lhs._time < rhs._time
    }
    
    public static func -(lhs: MachTime, rhs: MachTime) -> TimeInterval {
        return lhs.seconds - rhs.seconds
    }
}

extension FloatingPoint where Self: ExpressibleByFloatLiteral {
    /// Rescale a value to lie in within the new range.
    ///
    ///     let x = 0.5
    ///     let y = x.rescaled(to: 0.5 ... 1.0)
    ///     print(y)
    ///     // prints 0.75
    ///
    /// - Parameters:
    ///    - to: The range to rescale the value to
    ///    - from: The range value lies within. Defaults to (0.0...1.0)
    /// - Returns: The rescaled value
    @_transparent
    public func rescaled(to: ClosedRange<Self>, from: ClosedRange<Self> = 0.0...1.0 ) -> Self {
        return ((to.upperBound - to.lowerBound) * (self - from.lowerBound) / (from.upperBound - from.lowerBound)) + to.lowerBound
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
    
    /// Creates a new color with the given white and alpha.
    ///
    /// - Parameters:
    ///   - white: the white value from 0 to 1.
    ///   - alpha: the alpha value from 0 to 1.
    public init(white: CGFloat, alpha: CGFloat = 1.0) {
        if 0 <= white && white <= 1.0 {
            // valid white, no adjustment necessary.
        }
        uiColor = UIColor(white: white, alpha: alpha)
    }
    
    /// Creates a new color with the given HSBA values.
    ///
    /// - Parameters:
    ///   - hue: the hue value from 0 to 1.
    ///   - saturation: the saturation value from 0 to 1.
    ///   - brightness: the brightness value from 0 to 1.
    ///   - alpha: the alpha value from 0 to 1.
    public init(hue: Double, saturation: Double, brightness: Double, alpha: Double = 1.0) {
        uiColor = UIColor(hue: CGFloat(hue), saturation: CGFloat(saturation), brightness: CGFloat(brightness), alpha: CGFloat(alpha))
    }
    
    /// Creates a new color with the given RGBA values.
    ///
    /// - Parameters:
    ///   - red: the red value from 0 to 1.
    ///   - green: the green value from 0 to 1.
    ///   - blue: the blue value from 0 to 1.
    ///   - alpha: the alpha value from 0 to 1.
    public init(red: Double, green: Double, blue: Double, alpha: Double = 1.0) {
        uiColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }
    
    /// Creates a new color based on the given #UIColor
    ///
    /// - Parameter uiColor: the UIColor to base this Color on.
    internal init(_ uiColor: UIColor) {
        self.uiColor = uiColor
    }
    
    /// Creates a new color with the given RGBA values.
    ///
    /// - Parameters:
    ///   - red: the red value from 0 to 1.
    ///   - green: the green value from 0 to 1.
    ///   - blue: the blue value from 0 to 1.
    ///   - alpha: the alpha value from 0 to 1.
    public convenience required init(colorLiteralRed red: Float, green: Float, blue: Float, alpha: Float) {
        self.init(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
    }
    
    /// Returns a new color based on this color adjusted by the given lightness.
    ///
    /// - Parameter percent: amount to adjust the lightness.
    /// - Returns: new color with the adjusted lightness.
    public func lighter(percent: Double = 0.2) -> Color {
        return colorByAdjustingBrightness(percent: 1 + percent)
    }
    
    /// Returns a new color based on this color adjusted by the given alpha.
    ///
    /// - Parameter alpha: new alpha value.
    /// - Returns: new color with given alpha.
    public func withAlpha(alpha: Double) -> Color {
        return Color(uiColor.withAlphaComponent(CGFloat(alpha)))
    }
    
    /// Returns a new color based on this color adjusted by the given darkness.
    ///
    /// - Parameter percent: amount to adjust the darkness.
    /// - Returns: new color with the adjusted darkness.
    public func darker(percent: Double = 0.2) -> Color {
        return colorByAdjustingBrightness(percent: 1 - percent)
    }
    
    /// Returns a new color based on this color adjusted by the given brightness.
    ///
    /// - Parameter percent: amount to adjust the brightness.
    /// - Returns: new color with adjusted brightness
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
    
    
    /// Returns a random RGB color.
    ///
    /// - Returns: random color (i.e. color with random RGB values).
    public static func random() -> Color {
        let uint32MaxAsFloat = Float(UInt32.max)
        let red = Float(arc4random()) / uint32MaxAsFloat
        let blue = Float(arc4random()) / uint32MaxAsFloat
        let green = Float(arc4random()) / uint32MaxAsFloat
        
        return Color(red: Double(red), green: Double(green), blue: Double(blue), alpha: 1.0)
    }
    
    private static let standard = [purple, pink, green, blue, gray]
    
    private static var currentColorIndex = 0
    
    /// Returns the next of the standard colors.
    ///
    /// - Returns: the next of the standard colors.
    internal static func next() -> Color {
        let colorToReturn = standard[currentColorIndex]
        if (currentColorIndex == standard.count - 1) {
            currentColorIndex = 0
        } else {
            currentColorIndex += 1
        }
        
        return colorToReturn
    }
    
    /// Resets the standard color index, which drives the #next method.
    internal static func resetCurrentColor() {
        currentColorIndex = 0
    }
}
