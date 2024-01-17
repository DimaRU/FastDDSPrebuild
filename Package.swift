// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/v2.8.2/fastdds-v2.8.2.xcframework.zip",
                      checksum: "53ef96aa96c3235ceee9b5b6e5422889a7d3481ddefbc4b51bd91cbac71e6d26")
    ]
)
