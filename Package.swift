// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/v2.12.2/fastdds-v2.12.2.xcframework.zip",
                      checksum: "bddd530029cf4acc3243c9f3e12620829ea1d978ded4c642984b150442c4e6a8")
    ]
)
