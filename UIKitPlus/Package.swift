// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIKitPlus",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "UIKitPlus",
            targets: ["UIKitPlus"]),
    ],
    targets: [
        .target(
            name: "UIKitPlus"),
        .testTarget(
            name: "UIKit+Tests",
            dependencies: ["UIKitPlus"]
        ),
    ]
)
