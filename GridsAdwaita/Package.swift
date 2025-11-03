// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Grids",
    platforms: [ .macOS(.v13) ],
    dependencies: [
        .package(url: "https://git.aparoksha.dev/aparoksha/adwaita-swift", branch: "main"),
        .package(url: "https://git.aparoksha.dev/aparoksha/localized", branch: "main"),
        .package(url: "https://source.marquiskurt.net/What-the-Taiji/PuzzleKit", branch: "main"),
        .package(url: "https://source.marquiskurt.net/marquiskurt/DocumentKit", branch: "main")
    ],
    targets: [
        .executableTarget(
            name: "Grids",
            dependencies: [
                .product(name: "Adwaita", package: "adwaita-swift"),
                .product(name: "Localized", package: "localized"),
                .product(name: "PuzzleKit", package: "PuzzleKit"),
                .product(name: "DocumentKit", package: "DocumentKit")
            ],
            path: "Sources",
            resources: [
                .process("Resources")
            ],
            plugins: [
                .plugin(name: "GenerateLocalized", package: "localized")
            ]
        )
    ]
)
