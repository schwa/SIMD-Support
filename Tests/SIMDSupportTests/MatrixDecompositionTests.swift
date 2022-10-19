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
