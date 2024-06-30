// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyUtils",
    platforms: [
        .iOS(.v12)
    ],
    products: [
      .library(
          name: "SwiftPlus",
          targets: ["SwiftPlus"]),
        .library(
            name: "UIKitPlus",
            targets: ["UIKitPlus"]),
        .library(
            name: "SwiftUIPlus",
            targets: ["SwiftUIPlus"])
    ],
    targets: [
        .target(
            name: "UIKitPlus"),
        .target(
            name: "SwiftPlus"),
        .target(
            name: "SwiftUIPlus"),
        .testTarget(
            name: "UIKit+Tests",
            dependencies: ["UIKitPlus"]
        ),
    ]
)
