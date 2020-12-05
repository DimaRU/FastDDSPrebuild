// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/2.1.0-whitelist/fastrtps-2.1.0-whitelist.xcframework.zip",
                      checksum: "d810076aa6875b471a74b18a73a7cea7ccb6ed2bf08268cb3e7705993780481e")
    ]
)
