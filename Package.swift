// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/v2.14.2/fastdds-v2.14.2.xcframework.zip",
                      checksum: "9850f3fc0460a4f1b741f55cc4e97c26c31d7892003d2394e80f5ef81d28a4bb")
    ]
)
