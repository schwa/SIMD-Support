import CoreGraphics
import simd

#if os(macOS)
    import AppKit

    public extension SIMD4 where Scalar == Float {
        init(_ color: NSColor) {
            self = [Float(color.redComponent), Float(color.greenComponent), Float(color.blueComponent), Float(color.alphaComponent)]
        }
    }

    public extension NSColor {
        convenience init(_ color: SIMD4<Float>) {
            let color = color.map { CGFloat($0) }
            self.init(red: color[0], green: color[1], blue: color[2], alpha: color[3])
        }
    }
#endif

public extension SIMD3 where Scalar: BinaryFloatingPoint {
    init(_ cgColor: CGColor) {
        // TODO: Use linear color space. Piggy back of SIMD4
        let components = cgColor.components!.map { Scalar($0) }
        assert(components.count >= 3)
        self = SIMD3(Array(components[..<3]))
    }

    var cgColor: CGColor {
        // TODO: Use linear color space. Piggy back of SIMD4
        #if os(macOS)
            return CGColor(red: CGFloat(self[0]), green: CGFloat(self[1]), blue: CGFloat(self[2]), alpha: 1)
        #else
            fatalError("Unimplemented")
        #endif
    }
}

public extension SIMD4 where Scalar: BinaryFloatingPoint {
    var cgColor: CGColor {
        // TODO: use linear color space
        #if os(macOS)
            return CGColor(red: CGFloat(self[0]), green: CGFloat(self[1]), blue: CGFloat(self[2]), alpha: CGFloat(self[3]))
        #else
            fatalError("Unimplemented")
        #endif
    }
}
