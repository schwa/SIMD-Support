import simd

public extension SIMD3 where Scalar: Numeric {
    var volume: Scalar {
        x * y * z
    }
}

public func cos<V>(_ v: V) -> V where V: BinaryFloatingPoint {
    V(cos(Double(v)))
}

public func sin<V>(_ v: V) -> V where V: BinaryFloatingPoint {
    V(sin(Double(v)))
}

public func atan2<F>(_ y: F, _ x: F) -> F where F: BinaryFloatingPoint {
    F(atan2(Double(y), Double(x)))
}
