import Foundation
import simd
@testable import SIMDSupport
import XCTest

class TransformTests: XCTestCase {
    func testTransforms() {
        XCTAssertEqual("\(Transform())", "Transform(.identity)")
        XCTAssertEqual("\(Transform(scale: [3, 2, 1]))", "Transform(scale: [3, 2, 1])")
        XCTAssertEqual("\(Transform(rotation: .init(real: 1, imag: [2, 3, 4])))", "Transform(rotation: 1, [2, 3, 4])")
        XCTAssertEqual("\(Transform(translation: [1, 2, 3]))", "Transform(translation: [1, 2, 3])")
    }
}
