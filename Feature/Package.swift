// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Feature",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Feature",
            targets: ["Feature"]),
    ],
    dependencies: [
        .package(path: "../UseCase"),
        .package(path: "../Common")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Feature",
            dependencies: [
                "UseCase",
                "Common"
            ]
        ),
        .testTarget(
            name: "FeatureTests",
            dependencies: ["Feature"]
        ),
    ]
)
