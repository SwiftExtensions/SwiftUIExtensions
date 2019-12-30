// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swiftui-extensions",
    platforms: [
        .iOS(.v13), .macOS(.v10_15), .watchOS(.v6), .tvOS(.v13)
    ],
    products: [
        .library(name: "SwiftUIExtensions", targets: ["SwiftUIExtensions"]),
        .library(name: "Grid", targets: ["Grid"]),
        .library(name: "Sliders", targets: ["Sliders"]),
        .library(name: "Shapes", targets: ["Shapes"]),
        .library(name: "Chart", targets: ["Chart"]),
    ],
    targets: [
        .target(name: "SwiftUIExtensions", dependencies: ["Grid", "Sliders", "Shapes", "Chart"]),
        .target(name: "Grid", dependencies: []),
        .target(name: "Sliders", dependencies: []),
        .target(name: "Shapes", dependencies: []),
        .target(name: "Chart", dependencies: ["Shapes"]),
        .testTarget(name: "SwiftUIExtensionsTests", dependencies: ["SwiftUIExtensions"])
    ]
)
