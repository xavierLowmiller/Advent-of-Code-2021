// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Day1",
    products: [
        .library(
            name: "Day1",
            targets: ["Day1"]),
    ],
    targets: [
        .target(
            name: "Day1",
            dependencies: []),
        .testTarget(
            name: "Day1Tests",
            dependencies: ["Day1"]),
    ]
)
