import Foundation
import simd

public struct Angle<Value>: Equatable, Hashable, Comparable where Value: BinaryFloatingPoint {
    public var radians: Value

    public var degrees: Value {
        get {
            radiansToDegrees(radians)
        }
        set {
            radians = degreesToRadians(newValue)
        }
    }

    public init(radians: Value) {
        self.radians = radians
    }

    public init(degrees: Value) {
        radians = degreesToRadians(degrees)
    }

    public static func radians(_ radians: Value) -> Angle {
        Angle(radians: radians)
    }

    public static func degrees(_ degrees: Value) -> Angle {
        Angle(degrees: degrees)
    }

    public static func < (lhs: Angle<Value>, rhs: Angle<Value>) -> Bool {
        lhs.radians < rhs.radians
    }
}

// MARK: -

extension Angle: Codable where Value: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        radians = try container.decode(Value.self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(radians)
    }
}

// MARK: -

public struct AngleFormatStyle<Value>: FormatStyle where Value: BinaryFloatingPoint {
    public init() {}

    public func format(_ value: Angle<Value>) -> String {
        let degrees = FloatingPointFormatStyle().precision(.fractionLength(1)).format(value.degrees)
        return "\(degrees)°"
    }
}

public extension Angle {
    /// angle between the vector and the Z axis.
    init(x: Value, y: Value) {
        self = .init(radians: atan2(y, x))
    }
}

public extension Angle where Value: SIMDScalar {
    init(_ vector: SIMD2<Value>) {
        self = .init(radians: atan2(vector.y, vector.x))
    }

    init(from: SIMD2<Value>, to: SIMD2<Value>) {
        self = .init(to - from)
    }
}

public func atan2<F>(_ y: F, _ x: F) -> F where F: BinaryFloatingPoint {
    F(atan2(Double(y), Double(x)))
}
