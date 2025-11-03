// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GridsCore",
    defaultLocalization: "en",
    platforms: [.macOS(.v14), .iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "GridsCore",
            targets: ["GridsCore"]),
    ],
    dependencies: [
        .package(url: "https://source.marquiskurt.net/marquiskurt/DocumentKit", branch: "main"),
        .package(url: "https://source.marquiskurt.net/What-the-Taiji/PuzzleKit", branch: "main"),
        .package(url: "https://github.com/nalexn/ViewInspector", from: "0.10.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "GridsCore",
            dependencies: [
                .product(name: "DocumentKit", package: "DocumentKit"),
                .product(name: "PuzzleKit", package: "PuzzleKit")
            ],
            resources: [
                .process("Resources")
            ]),
        .testTarget(
            name: "GridsCoreTests",
            dependencies: [
                "GridsCore",
                .product(name: "PuzzleKit", package: "PuzzleKit"),
                .product(name: "ViewInspector", package: "ViewInspector", condition: .when(platforms: [.macOS, .iOS])),
            ]
        ),
    ]
)
