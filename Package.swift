// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/v2.6.7/fastdds-v2.6.7.xcframework.zip",
                      checksum: "79d9c2d82332c8a06d921eca5fee7de7ae182309aeb5eb764ea5d805d2348342")
    ]
)
