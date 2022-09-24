import simd

public extension simd_quatf {
    static var identity: simd_quatf {
        simd_quatf(real: 1, imag: .zero)
    }
}

extension simd_quatf: Codable {
    enum CodingKeys: CodingKey {
        case real
        case imaginary
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let real = try container.decode(Float.self, forKey: .real)
        let imaginary = try container.decode(SIMD3<Float>.self, forKey: .imaginary)
        self = .init(real: real, imag: imaginary)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(real, forKey: .real)
        try container.encode(imag, forKey: .imaginary)
    }
}

extension simd_quatf: Hashable {
    public func hash(into hasher: inout Hasher) {
        vector.hash(into: &hasher)
    }
}
