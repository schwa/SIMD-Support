import Foundation
import simd

public extension simd_float4x4 {
    @inlinable init(scale s: SIMD3<Float>) {
        self = simd_float4x4(columns: (
            [s.x, 0, 0, 0],
            [0, s.y, 0, 0],
            [0, 0, s.z, 0],
            [0, 0, 0, 1]
        ))
    }

    @inlinable init(translate t: SIMD3<Float>) {
        self = simd_float4x4(columns: (
            [1, 0, 0, 0],
            [0, 1, 0, 0],
            [0, 0, 1, 0],
            [t.x, t.y, t.z, 1]
        ))
    }

    @inlinable init(rotationAngle angle: Float, axis: SIMD3<Float>) {
        let quat = simd_quaternion(angle, axis)
        self = simd_float4x4(quat)
    }

    @inlinable static func scaled(_ s: SIMD3<Float>) -> simd_float4x4 {
        simd_float4x4(scale: s)
    }

    @inlinable static func translation(_ t: SIMD3<Float>) -> simd_float4x4 {
        simd_float4x4(translate: t)
    }

    @inlinable static func rotation(angle: Float, axis: SIMD3<Float>) -> simd_float4x4 {
        return simd_float4x4(simd_quaternion(angle, axis))
    }
}

public extension simd_float4x4 {
    @inlinable init(_ m: simd_float3x3) {
        self = simd_float4x4(columns: (
            SIMD4<Float>(m.columns.0, 0),
            SIMD4<Float>(m.columns.1, 0),
            SIMD4<Float>(m.columns.2, 0),
            [0, 0, 0, 1]
        ))
    }
}

// MARK: Rows

public extension simd_float4x4 {
    // swiftlint:disable:next large_tuple
    @inlinable init(rows: (SIMD4<Float>, SIMD4<Float>, SIMD4<Float>, SIMD4<Float>)) {
        self = simd_float4x4(columns: rows).transpose
    }

    var rows: (SIMD4<Float>, SIMD4<Float>, SIMD4<Float>, SIMD4<Float>) {
        (row(0), row(1), row(2), row(3))
    }

    private func row(_ row: Int) -> SIMD4<Float> { [
        self[0, row],
        self[1, row],
        self[2, row],
        self[3, row],
    ] }

    @inlinable var diagonal: SIMD4<Float> {
        SIMD4<Float>([self[0, 0], self[1, 1], self[2, 2], self[3, 3]])
    }
}

// MARK: Cells

public extension simd_float4x4 {
    @inlinable init(scalars: [Scalar]) {
        self = .identity
        self.scalars = scalars
    }

    @inlinable var scalars: [Scalar] {
        get {
            withUnsafeBytes(of: self) { buffer in
                assert(buffer.count == 64)
                let buffer = buffer.bindMemory(to: Scalar.self)
                assert(buffer.count == 16)
                let a = Array(buffer)
                assert(a.count == 16)
                return a
            }
        }
        set {
            newValue.withUnsafeBytes { newValue in
                assert(newValue.count >= 64)
                withUnsafeMutableBytes(of: &self) { matrix in
                    let count = newValue.copyBytes(to: matrix, count: matrix.count)
                    assert(count == 64)
                }
            }
        }
    }
}

// MARK: More

public extension simd_float4x4 {
    @inlinable static func * (lhs: simd_float4x4, rhs: simd_quatf) -> simd_float4x4 {
        lhs * simd_float4x4(rhs)
    }

    @inlinable static func * (lhs: simd_quatf, rhs: simd_float4x4) -> simd_float4x4 {
        simd_float4x4(lhs) * rhs
    }
}

public extension float4x4 {
    @available(*, deprecated, message: "Too specialised.")
    @inlinable var normalMatrix: float3x3 {
        let upperLeft = float3x3(self[0].xyz, self[1].xyz, self[2].xyz)
        return upperLeft.transpose.inverse
    }
}

public extension simd_float4x4 {
    @inlinable func map<R>(_ f: (SIMD4<Float>) throws -> R) rethrows -> [R] {
        try [columns.0, columns.1, columns.2, columns.3].map(f)
    }
}

public extension simd_float3x3 {
    @inlinable init(truncating other: simd_float4x4) {
        self = other.truncated3x3
    }
}

public extension simd_float4x4 {
    var truncated3x3: simd_float3x3 {
        simd_float3x3(map(\.xyz).dropLast())
    }
}
