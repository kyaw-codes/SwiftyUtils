// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyUtils",
    platforms: [
      .iOS(.v13)
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
            targets: ["SwiftUIPlus"]),
      .library(
          name: "SwiftUIComponents",
          targets: ["SwiftUIComponents"])
    ],
    dependencies: [
      .package(url: "https://github.com/SwifterSwift/SwifterSwift.git", from: "6.0.0")
    ],
    targets: [
        .target(
          name: "UIKitPlus", dependencies: ["SwiftPlus"]),
        .target(
          name: "SwiftPlus",
          dependencies: [
            "SwifterSwift",
          ]),
        .target(
            name: "SwiftUIPlus", dependencies: ["SwiftPlus"]),
        .target(
            name: "SwiftUIComponents", dependencies: ["SwiftPlus", "UIKitPlus", "SwiftUIPlus"]),
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
