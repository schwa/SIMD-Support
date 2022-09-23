import XCTest
@testable import SIMDSupport

final class CoreGraphics_DocTests: XCTestCase {
    func test_0320de03() throws {
        XCTAssertEqual(CGPoint(SIMD2<Float>(1, 2)), CGPoint(x: 1, y: 2))
    }

    func test_04302004() throws {
        XCTAssertEqual(CGSize(SIMD2<Float>(1, 2)), CGSize(width: 1, height: 2))
    }

    func test_0ee0bd0e() throws {
        XCTAssertEqual(SIMD2<Float>(CGPoint(x: 1, y: 2)), SIMD2<Float>(1, 2))
    }

    func test_09409301() throws {
        XCTAssertEqual(SIMD2<Float>(CGSize(width: 1, height: 2)), SIMD2<Float>(1, 2))
    }

}   

final class SIMDSwizzling_DocTests: XCTestCase {
    func test_0f901808() throws {
        XCTAssertEqual(SIMD3<Float>(1, 2, 3).xy, SIMD2<Float>(1, 2))
    }

}   

