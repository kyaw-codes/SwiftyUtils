// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIKit+",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "UIKit+",
            targets: ["UIKit+"]),
    ],
    targets: [
        .target(
            name: "UIKit+"),
        .testTarget(
            name: "UIKit+Tests",
            dependencies: ["UIKit+"]
        ),
    ]
)
