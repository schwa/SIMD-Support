import CoreGraphics
import simd

public extension CGPoint {
    init<Scalar>(_ vector: SIMD2<Scalar>) where Scalar: BinaryFloatingPoint {
        self = CGPoint(x: CGFloat(vector.x), y: CGFloat(vector.y))
    }
}

public extension CGSize {
    init<Scalar>(_ vector: SIMD2<Scalar>) where Scalar: BinaryFloatingPoint {
        self.init(width: CGFloat(vector.x), height: CGFloat(vector.y))
    }
}

public extension SIMD2 where Scalar: BinaryFloatingPoint {
    init(_ point: CGPoint) {
        self = SIMD2<Scalar>(Scalar(point.x), Scalar(point.y))
    }

    init(_ size: CGSize) {
        self = SIMD2<Scalar>(Scalar(size.width), Scalar(size.height))
    }
}
