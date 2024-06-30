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
          name: "UIKitPlus", dependencies: ["SwiftPlus"]),
        .target(
            name: "SwiftPlus"),
        .target(
            name: "SwiftUIPlus", dependencies: ["SwiftPlus"]),
        .testTarget(
            name: "UIKitPlusTests",
            dependencies: ["UIKitPlus"]
        ),
        .testTarget(
            name: "SwiftUIPlusTests",
            dependencies: ["SwiftUIPlus"]
        ),
        .testTarget(
            name: "SwiftPlusTests",
            dependencies: ["SwiftPlus"]
        )
    ]
)
