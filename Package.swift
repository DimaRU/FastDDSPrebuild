// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/2.0.2/fastrtps-2.0.2.xcframework.zip",
                      checksum: "233332c7438b97c3cc43589de4df22e77c0b0ad68d44bd4f9827978b5ebbd62f")
    ]
)
