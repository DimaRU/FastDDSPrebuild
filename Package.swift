// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/v2.13.3/fastdds-v2.13.3.xcframework.zip",
                      checksum: "32ecd8ce3528d837d13089e259dcc76d97b9538d0f7fb8023fa81808f5202b21")
    ]
)
