// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/v2.13.6/fastdds-v2.13.6.xcframework.zip",
                      checksum: "3c2fd91ba2a3da24e3782be2926cd2750598a105bd2a20781b875037b966acba")
    ]
)
