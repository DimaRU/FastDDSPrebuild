// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/v2.14.1/fastdds-v2.14.1.xcframework.zip",
                      checksum: "8282907e39d761a5f93999fd6475dc3e46f9227a5d445ac8abfe618fbb67bbbb")
    ]
)
