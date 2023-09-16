// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SIMDSupport",
    platforms: [
        .iOS("15.0"),
        .macOS("12.0"),
        .macCatalyst("15.0"),
    ],
    products: [
        .library(
            name: "SIMDSupport",
            targets: ["SIMDSupport"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/schwa/ApproximateEquality", from: "0.1.1")
    ],
    targets: [
        .target(
            name: "SIMDSupport",
            dependencies: [
                .product(name: "ApproximateEquality", package: "ApproximateEquality")
            ]
        ),
        .target(
            name: "SIMDSupportUnsafeConformances",
            dependencies: []
        ),
        .testTarget(
            name: "SIMDSupportTests",
            dependencies: ["SIMDSupport"]
        ),
    ]
)
