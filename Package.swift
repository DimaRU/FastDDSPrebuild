// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/v2.13.2/fastdds-v2.13.2.xcframework.zip",
                      checksum: "48eb5d315e1e8fa2e12168d104592c1812cf246bfb249893a7b36a4c1bd6a6b8")
    ]
)
