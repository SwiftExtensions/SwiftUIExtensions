// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Grid",
    platforms: [
        .iOS(.v13), .macOS(.v10_15), .watchOS(.v6), .tvOS(.v13)
    ],
    products: [
        .library(name: "Grid", targets: ["Grid"])
    ],
    targets: [
        .target(name: "Grid", dependencies: []),
        .testTarget(name: "GridTests", dependencies: ["Grid"])
    ]
)
