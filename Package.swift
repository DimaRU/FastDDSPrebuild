// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/v2.14.3/fastdds-v2.14.3.xcframework.zip",
                      checksum: "eb21d0e2551958d675bafe893ecd00d3979c69bbd137a17deddd9fa4a659e94e")
    ]
)
