// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MaterialSymbolsKit",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .watchOS(.v9),
        .tvOS(.v16)
    ],
    products: [
        .library(
            name: "MaterialSymbolsKit",
            targets: ["MaterialSymbolsKit"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MaterialSymbolsKit",
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "MaterialSymbolsKitTests",
            dependencies: ["MaterialSymbolsKit"]
        ),
    ]
)
