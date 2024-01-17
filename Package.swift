// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/v2.13.1/fastdds-v2.13.1.xcframework.zip",
                      checksum: "6f460612787e8e7b03e048167340efdb2d7a2597754fb81a650241c49516e140")
    ]
)
