// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/v2.9.2/fastdds-v2.9.2.xcframework.zip",
                      checksum: "8e67f85dbbbcba781788427db8c0d637e21558d0cae4abac9b831a0feb532be1")
    ]
)
