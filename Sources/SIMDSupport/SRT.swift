import simd

/**
A type to represent a 3d transformation as a concatenation of a rotation, a translation and a scale.
*/
public struct SRT: Equatable {
    public var scale: SIMD3<Float> = .unit
    public var rotation: simd_quatf = .identity
    public var translation: SIMD3<Float> = .zero

    public init(scale: SIMD3<Float> = .unit, rotation: simd_quatf = .identity, translation: SIMD3<Float> = .zero) {
        self.scale = scale
        self.rotation = rotation
        self.translation = translation
    }

    public var matrix: simd_float4x4 {
        let scaleMatrix = simd_float4x4(scale: scale)
        let rotationMatrix = simd_float4x4(rotation)
        let translationMatrix = simd_float4x4(translate: translation)
        return translationMatrix * rotationMatrix * scaleMatrix
    }
}

@available(iOS 17, macOS 14, macCatalyst 17, *)
extension SRT: Hashable {    
}

// MARK: -

@available(iOS 17, macOS 14, macCatalyst 17, *)
extension SRT: Codable {
    enum CodingKeys: CodingKey {
        case scale
        case rotation
        case translation
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        scale = try container.decodeIfPresent(SIMD3<Float>.self, forKey: .scale) ?? .unit
        rotation = try container.decodeIfPresent(SIMD4<Float>.self, forKey: .rotation).map { simd_quatf(vector: $0) } ?? .identity
        translation = try container.decodeIfPresent(SIMD3<Float>.self, forKey: .translation) ?? .zero
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(scale, forKey: .scale)
        try container.encode(rotation.vector, forKey: .rotation)
        try container.encode(translation, forKey: .translation)
    }
}

extension SRT: CustomStringConvertible {
    public var description: String {
        "SRT(\(innerDescription))"
    }
    
    internal var innerDescription: String {
        let scale = scale == .unit ? nil : "scale: [\(scale.x.formatted()), \(scale.y.formatted()), \(scale.z.formatted())]"
        let rotation = rotation == .identity ? nil : "rotation: \(rotation.innerDescription)"
        let translation = translation == .zero ? nil : "translation: [\(translation.x.formatted()), \(translation.y.formatted()), \(translation.z.formatted())]"
        return [scale, rotation, translation].compactMap({ $0 }).joined(separator: ",")
    }
}
