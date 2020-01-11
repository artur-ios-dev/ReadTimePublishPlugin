// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReadTimePublishPlugin",
    products: [
        .library(
            name: "ReadTimePublishPlugin",
            targets: ["ReadTimePublishPlugin"]),
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "ReadTimePublishPlugin",
            dependencies: ["Publish"]),
        .testTarget(
            name: "ReadTimePublishPluginTests",
            dependencies: ["ReadTimePublishPlugin"]),
    ]
)
