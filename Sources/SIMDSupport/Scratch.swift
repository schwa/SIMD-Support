import simd

public struct EulerRotation {
    public var angle: Float
    public var axis: SIMD3<Float>
}

public extension EulerRotation {
    init(_ r: simd_quatf) {
        angle = r.angle
        axis = r.axis
    }
}

public extension simd_quatf {
    init(_ r: EulerRotation) {
        self = simd_quatf(angle: r.angle, axis: r.axis)
    }
}

public extension simd_quatf {
    init(angle: Angle<Float>, axis: SIMD3<Float>) {
        self = simd_quatf(angle: angle.radians, axis: axis)
    }
}

public extension Angle where Value.RawSignificand: FixedWidthInteger {
    static func randomDegrees(in range: ClosedRange<Value>) -> Angle {
        let value = Value.random(in: range)
        return Angle.degrees(value)
    }
}

public extension Transform {
    func rotated(_ r: simd_quatf) -> Transform {
        var copy = self
        copy.rotation *= r
        return copy
    }

    func rotated(angle: Angle<Float>, axis: SIMD3<Float>) -> Transform {
        rotated(simd_quatf(angle: angle, axis: axis))
    }
}

public extension SIMD3 where Scalar: Numeric {
    var volume: Scalar {
        x * y * z
    }
}

public extension SIMD2 where Scalar: BinaryFloatingPoint {
    init(length: Scalar, angle: Angle<Scalar>) {
        self = SIMD2(cos(angle.radians) * length, sin(angle.radians))
    }
}

public func cos<V>(_ v: V) -> V where V: BinaryFloatingPoint {
    V(cos(Double(v)))
}

public func sin<V>(_ v: V) -> V where V: BinaryFloatingPoint {
    V(sin(Double(v)))
}
