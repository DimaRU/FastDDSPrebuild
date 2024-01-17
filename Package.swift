// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/v2.3.6/fastdds-v2.3.6.xcframework.zip",
                      checksum: "c941ba82fe6945ea3f5be73a3d6cdacd4f61ff06e0acfa062ea8bdd66f0410f0")
    ]
)
