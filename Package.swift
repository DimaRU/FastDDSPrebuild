// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/2.0.1/fastrtps-2.0.1.xcframework.zip",
                      checksum: "235e395e05565949805649800fe0c5775713b0b4f2694307ab7ac1e1851c190f")
    ]
)
