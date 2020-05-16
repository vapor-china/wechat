// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "wechat-pay",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "WechatPay", targets: ["WechatPay"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0-rc"),
        .package(url: "https://github.com/apple/swift-crypto.git", from: "1.0.1"),
        .package(url: "https://github.com/vapor-china/coda-wrapper.git", from: "1.0.0")
    ],
    targets: [
        .target(name: "WechatPay", dependencies: [
            .product(name: "Vapor", package: "vapor"),
            .product(name: "Crypto", package: "swift-crypto"),
            .product(name: "Coda", package: "coda-wrapper")
        ])
    ]
)
