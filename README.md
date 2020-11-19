# FastDDSPrebuild
## Prebuilt Fast-DDS (formerly FastRTPS) library for Apple platforms.


### Supported platforms and architectures
| Platform          |  Architectures     |
|-------------------|--------------------|
| macOS             | x86_64 arm64       |
| iOS               | arm64 armv7 armv7s |
| iOS Simulator     | x86_64 arm64       |
| Mac Catalyst      | x86_64 arm64       |

### Usage

Add line to you package.swift dependencies:

```
.package(name: "FastDDS", url: "https://github.com/DimaRU/FastDDSPrebuild.git", .upToNextMajor(from: "2.0.0"))


```

Right now used with the FastRTPSBridge library: [https://github.com/DimaRU/FastRTPSBridge](https://github.com/DimaRU/FastRTPSBridge)

### Xcode 12 bug note!

Xcode 12 now has a bug that causes static library .a files to be copied into the app bundle. Add `Run Script` to your Xcode project with this commands:

```
# Remove static libs
ls -1 ${CODESIGNING_FOLDER_PATH}/Contents/Frameworks/*.a
rm -f ${CODESIGNING_FOLDER_PATH}/Contents/Frameworks/*.a

```

### Build your own repo from source

Required Xcode 12.2, and [github cli](https://github.com/cli/cli). Intended to use with github.

1. Install gh: `brew install gh`
2. Authorize gh: `gh auth`
2. Fork and clone this repo
3. Run `./script/fastrtps_build_xctframework.sh 2.1.0 commit`
