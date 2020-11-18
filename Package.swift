// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/2.1.0/fastrtps-2.1.0.xcframework.zip",
                      checksum: "efdb24d6a6bc3f666a815061d18f836c10c717db01cfbe040d4b8b80b52a3a1b")
    ]
)
