// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/v2.14.0/fastdds-v2.14.0.xcframework.zip",
                      checksum: "426baa29e0ac6fdf82021a3d6e6c0d091814a0a41fb290a71ef701f598a6f71b")
    ]
)
