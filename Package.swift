// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/v2.12.1/fastdds-v2.12.1.xcframework.zip",
                      checksum: "fc17b4d655e5c0e7ee0bf86724511a70ddb0065dfb2c5fb8d3e3d969f4a3e7f7")
    ]
)
