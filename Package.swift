// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/v2.1.4/fastdds-v2.1.4.xcframework.zip",
                      checksum: "23c259e5ccd331e84bf4c7425604171954cf161ea987e725f7260f0c0bd830d1")
    ]
)
