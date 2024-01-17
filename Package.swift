// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/v2.4.2/fastdds-v2.4.2.xcframework.zip",
                      checksum: "1c3cf1693708b743945b061705e2ab1d094c7e513428dc40ad9ec9ec02d5678e")
    ]
)
