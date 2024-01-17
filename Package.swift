// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/v2.6.6/fastdds-v2.6.6.xcframework.zip",
                      checksum: "c0c032e673305abd3c01d53f23633807bb0c67474032a924e2c9644ff61bd00f")
    ]
)
