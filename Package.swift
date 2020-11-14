// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/2.0.2-whitelist/fastrtps-2.0.2-whitelist.xcframework.zip",
                      checksum: "20bd313c4719d5bc288f9b9d15848124be36758026d4be2c5d62b21da15430a2")
    ]
)
