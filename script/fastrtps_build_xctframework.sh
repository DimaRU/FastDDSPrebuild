#!/bin/bash
#
# fastrtps_build_xctframework.sh
# Copyright © 2020 Dmitriy Borovikov. All rights reserved.
#
set -e
set -x

TAG="2.0.1"
BRANCH=$(git branch --show-current)
if [ "$BRANCH" == "master" ]
then
    Foonathan_memory_repo="-b crosscompile https://github.com/DimaRU/memory.git"
    FastRTPS_repo="-b v2.0.1 https://github.com/eProsima/Fast-DDS.git"

elif [ "$BRANCH" == "whitelist" ]
then
	TAG="$BRANCH-$TAG"
    Foonathan_memory_repo="-b crosscompile https://github.com/DimaRU/memory.git"
    FastRTPS_repo="-b feature/remote-whitelist-2.0.1 https://github.com/DimaRU/Fast-DDS.git"
else
    echo "Wrong branch $BRANCH"
    exit -1
fi
echo $TAG

ZIPNAME=fastrtps-$TAG.xcframework.zip
GIT_REMOTE_URL_UNFINISHED=`git config --get remote.origin.url|sed "s=^ssh://==; s=^https://==; s=:=/=; s/git@//; s/.git$//;"`
DOWNLOAD_URL=https://$GIT_REMOTE_URL_UNFINISHED/releases/download/$TAG/$ZIPNAME

export ROOT_PATH=$(cd "$(dirname "$0")/.."; pwd -P)
pushd $ROOT_PATH > /dev/null

BUILD=$ROOT_PATH/build
export PROJECT_TEMP_DIR=$BUILD/temp
export SOURCE_DIR=$BUILD/src

if [ ! -d $SOURCE_DIR/memory ]; then
git clone --quiet --recurse-submodules --depth 1 $Foonathan_memory_repo $SOURCE_DIR/memory
fi
if [ ! -d $SOURCE_DIR/Fast-DDS ]; then
git clone --quiet --recurse-submodules --depth 1 $FastRTPS_repo $SOURCE_DIR/Fast-DDS
fi

export BUILT_PRODUCTS_DIR=$BUILD/macosx
export PLATFORM_NAME=macosx
export EFFECTIVE_PLATFORM_NAME=""
export ARCHS="x86_64 arm64"
script/fastrtps_build_apple.sh

export BUILT_PRODUCTS_DIR=$BUILD/maccatalyst
export PLATFORM_NAME=macosx
export EFFECTIVE_PLATFORM_NAME="-maccatalyst"
export ARCHS="x86_64 arm64"
script/fastrtps_build_apple.sh

export BUILT_PRODUCTS_DIR=$BUILD/iphoneos
export PLATFORM_NAME=iphoneos
export EFFECTIVE_PLATFORM_NAME="-iphoneos"
export ARCHS="armv7 armv7s arm64"
script/fastrtps_build_apple.sh

export BUILT_PRODUCTS_DIR=$BUILD/iphonesimulator
export PLATFORM_NAME=iphonesimulator
export EFFECTIVE_PLATFORM_NAME="-iphonesimulator"
export ARCHS="x86_64 arm64"
script/fastrtps_build_apple.sh

xcodebuild -create-xcframework \
-library $BUILD/macosx/lib/libfastrtpsa.a \
-headers $BUILD/macosx/include \
-library $BUILD/iphoneos/lib/libfastrtpsa.a \
-headers $BUILD/iphoneos/include \
-library $BUILD/iphonesimulator/lib/libfastrtpsa.a \
-headers $BUILD/iphonesimulator/include \
-library $BUILD/maccatalyst/lib/libfastrtpsa.a \
-headers $BUILD/maccatalyst/include \
-output FastDDS.xcframework
zip --recurse-paths --quiet $ZIPNAME FastDDS.xcframework
rm -rf FastDDS.xcframework

CHECKSUM=`shasum -a 256 -b $ZIPNAME | awk '{print $1}'`

cat >Package.swift << EOL
// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FastDDS",
    products: [
        .library(name: "FastDDS", targets: ["FastDDS"])
    ],
    targets: [
        .binaryTarget(name: "FastDDS",
                      url: "$DOWNLOAD_URL",
                      checksum: "$CHECKSUM")
    ]
)
EOL

popd > /dev/null
