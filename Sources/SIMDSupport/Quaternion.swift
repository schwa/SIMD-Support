import simd

public extension simd_quatf {
    static var identity: simd_quatf {
        simd_quatf(real: 1, imag: .zero)
    }
}

public extension simd_quatf {
    init(_ quaternion: simd_quatd) {
        self = simd_quatf(real: Float(quaternion.real), imag: SIMD3<Float>(quaternion.imag))
    }
}

// MARK: -

public extension simd_quatd {
    static var identity: simd_quatd {
        simd_quatd(real: 1, imag: .zero)
    }
}

extension simd_quatd: Codable {
    enum CodingKeys: CodingKey {
        case real
        case imaginary
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let real = try container.decode(Double.self, forKey: .real)
        let imaginary = try container.decode(SIMD3<Double>.self, forKey: .imaginary)
        self = .init(real: real, imag: imaginary)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(real, forKey: .real)
        try container.encode(imag, forKey: .imaginary)
    }
}

public extension simd_quatd {
    init(_ quaternion: simd_quatf) {
        self = simd_quatd(real: Double(quaternion.real), imag: SIMD3<Double>(quaternion.imag))
    }
}
