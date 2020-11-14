// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/2.0.1-whitelist/fastrtps-2.0.1-whitelist.xcframework.zip",
                      checksum: "f398dc352cbe06651bce63b730ad5318135a04ae403fd7b84b1fd59eb6b5e382")
    ]
)
