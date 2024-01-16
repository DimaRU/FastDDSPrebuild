# FastDDSPrebuild
## Prebuilt Eprosima [Fast-DDS](https://github.com/eProsima/Fast-DDS) (formerly FastRTPS) library for Apple platforms.


### Supported platforms and architectures
| Platform          |  Architectures     |
|-------------------|--------------------|
| macOS             | x86_64 arm64       |
| iOS               | arm64 armv7 armv7s |
| iOS Simulator     | x86_64 arm64       |
| Mac Catalyst      | x86_64 arm64       |
| xrOS              | arm64              |
| xrOS Simulator    | arm64              |

### Usage

Add line to you package.swift dependencies:

```
.package(url: "https://github.com/DimaRU/FastDDSPrebuild.git", from: "2.0.0")
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

#### Requirements 

- Xcode 15
- cmake 3.28
- [github cli](https://github.com/cli/cli). GitHub’s official command line tool.
- [xczip](https://github.com/DimaRU/xczip). Create xcframework zip archive for Swift binary package.

#### Steps for build

1. Install gh: `brew install gh`
2. Install xczip: `brew install DimaRU/formulae/xczip`
3. Authorize gh: `gh auth`
4. Clone this repo
5. Checkout *script* branch `git switch script`
6. Make your own repo
5. Run `./script/fastrtps_build_xctframework.sh repo_path v2.6.1 commit`
