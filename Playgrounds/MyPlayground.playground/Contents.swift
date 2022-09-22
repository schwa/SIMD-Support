import Cocoa
import simd
@testable import SIMDSupport

let srt = SRT(scale: [3, 2, 1])
let matrix = srt.matrix
let decomposed = matrix.polarDecompose

print("DONe")

// for key in simd_float4x4.identity {
// }

extension simd_float4x4 {
    var indices: [SIMD2<Int>] {
        return [
            [0, 0],
            [0, 1],
            [0, 2],
            [0, 3],
            [1, 0],
            [1, 1],
            [1, 2],
            [1, 3],
            [2, 0],
            [2, 1],
            [2, 2],
            [2, 3],
            [3, 0],
            [3, 1],
            [3, 2],
            [3, 3],
        ]
    }

    subscript(index: SIMD2<Int>) -> Float {
        get {
            return self[index.x, index.y]
        }
        set {
            self[index.x, index.y] = newValue
        }
    }
}

for i in matrix.indices {
    print(matrix[i])
}
