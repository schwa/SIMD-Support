import Foundation
import simd
@testable import SIMDSupport
import XCTest

class MatrixDecompositionTests: XCTestCase {
    func testIdentity() {
        let srt = SRT()
        let matrix = srt.matrix
        XCTAssertTrue(matrix.isAffine)
        let decomposed = matrix.decompose
        XCTAssertEqual(srt, decomposed)
    }

    func testScale() {
        let srt = SRT(scale: [3, 2, 1])
        let matrix = srt.matrix
        print(matrix)
        XCTAssertTrue(matrix.isAffine)
        let decomposed = matrix.decompose
        print(decomposed.matrix)
        XCTAssertEqual(srt, decomposed)
    }

    func testRotation() {
        let rotation = simd_float4x4(simd_quatf(angle: .degrees(90), axis: [0, 1, 0]))
        let srt = SRT(rotation: rotation)
        let matrix = srt.matrix
        XCTAssertTrue(matrix.isAffine)
        let decomposed = matrix.decompose
        XCTAssertEqual(simd_float4x4(srt.rotation), simd_float4x4(decomposed.rotation), accuracy: .ulpOfOne)
    }

    func testTranslation() {
        let srt = SRT(translation: [3, 2, 1])
        let matrix = srt.matrix
        XCTAssertTrue(matrix.isAffine)
        let decomposed = matrix.decompose
        XCTAssertEqual(srt, decomposed)
    }
}

public func XCTAssertEqual<T>(_ expression1: @escaping @autoclosure () throws -> [T], _ expression2: @escaping @autoclosure () throws -> [T], accuracy: T, _ message: @escaping @autoclosure () -> String = "", file: StaticString = #filePath, line: UInt = #line) where T: Numeric {
    XCTAssertNoThrow {
        zip(try expression1(), try expression2()).forEach {
            XCTAssertEqual($0, $1, accuracy: accuracy, message(), file: file, line: line)
        }
    }
}

public func XCTAssertEqual(_ expression1: @escaping @autoclosure () throws -> simd_float4x4, _ expression2: @escaping @autoclosure () throws -> simd_float4x4, accuracy: Float, _ message: @escaping @autoclosure () -> String = "", file: StaticString = #filePath, line: UInt = #line) {
    XCTAssertEqual(try expression1().scalars, try expression2().scalars, accuracy: accuracy, message(), file: file, line: line)
}
