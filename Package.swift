// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "https://github.com/DimaRU/FastDDSPrebuild/releases/download/v2.5.2/fastdds-v2.5.2.xcframework.zip",
                      checksum: "df6d909514e97df2328f4e21e8a3a1db69c5e42669893aacac49017b5f89db71")
    ]
)
