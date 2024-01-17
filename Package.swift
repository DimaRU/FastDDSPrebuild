// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/v2.11.2/fastdds-v2.11.2.xcframework.zip",
                      checksum: "7f62195ff762bc6472bca2aeb1d17584db5cf9cb573a948132b3194146ab806b")
    ]
)
