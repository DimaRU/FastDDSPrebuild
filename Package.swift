// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/v2.7.2/fastdds-v2.7.2.xcframework.zip",
                      checksum: "a1d574949dfdb554cdef1c6bddf2bb506d6fc225e332389ddf997240f45c31fb")
    ]
)
