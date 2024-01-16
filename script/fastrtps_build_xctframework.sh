#!/bin/bash
#
# fastrtps_build_xctframework.sh
# Copyright © 2024 Dmitriy Borovikov. All rights reserved.
#
set -e

if [[ $# > 1 ]]; then
REPO_PATH=$1
TAG=$2
else
echo "Usage: fastrtps_build_xctframework.sh REPO_PATH TAG commit"
echo "where TAG is Fast-DDS version tag eg. v2.0.1"
exit -1
fi

export ROOT_PATH=$(cd "$(dirname "$0")/.."; pwd -P)
source $ROOT_PATH/script/fastrtps_build_apple.sh

pushd $REPO_PATH > /dev/null

export BUILD=$REPO_PATH/build
export SOURCE_DIR=$BUILD/src

#make tag
BRANCH=$(git branch --show-current)
if [ "$BRANCH" == "master" ]
then
    FastRTPS_repo="-b $TAG https://github.com/eProsima/Fast-DDS.git"
    ReleaseNote=""
elif [ "$BRANCH" == "whitelist" ]
then
    FastRTPS_repo="-b feature/remote-whitelist-$TAG https://github.com/DimaRU/Fast-DDS.git"
    ReleaseNote="Remote whitelist feature."
    TAG="$TAG-$BRANCH"
else
    echo "Wrong branch $BRANCH"
    exit -1
fi

ZIPNAME=fastdds-$TAG.xcframework.zip
GIT_REMOTE_URL_UNFINISHED=`git config --get remote.origin.url|sed "s=^ssh://==; s=^https://==; s=:=/=; s/git@//; s/.git$//;"`
DOWNLOAD_URL=https://$GIT_REMOTE_URL_UNFINISHED/releases/download/$TAG/$ZIPNAME

#clone
if [ ! -d $SOURCE_DIR/memory ]; then
echo "Clone foonathan memory"
git -c advice.detachedHead=false clone --quiet https://github.com/foonathan/memory.git --branch v0.7-3 --depth 1 $SOURCE_DIR/memory
fi
if [ ! -d $SOURCE_DIR/Fast-DDS ]; then
echo "Clone $FastRTPS_repo"
git -c advice.detachedHead=false clone --quiet --recurse-submodules --depth 1 $FastRTPS_repo $SOURCE_DIR/Fast-DDS
fi

# Check FastDDS tag
pushd $SOURCE_DIR/Fast-DDS > /dev/null
GIT_TAG=$(git describe --tags)
if [ "$TAG" != "$GIT_TAG" ]
then
    echo "Entered wrong FastDDS tag $TAG"
    exit 1
fi
DATE=$(git tag -l --format="%(creatordate:iso)" $TAG)
popd > /dev/null

# path
if grep "<net/if_arp.h>" -s $SOURCE_DIR/Fast-DDS/src/cpp/utils/IPFinder.cpp >/dev/null
then
    if ! grep "TARGET_OS_IPHONE" -s $SOURCE_DIR/Fast-DDS/src/cpp/utils/IPFinder.cpp >/dev/null
    then
        curl --output $BUILD/IPFinder.cpp.patch https://github.com/eProsima/Fast-DDS/commit/448a18f361c728cab9729f8acf087a3f6c1e78f5.patch
        patch --directory=$SOURCE_DIR/Fast-DDS -p1 <$BUILD/IPFinder.cpp.patch
    fi
fi

set +e
xcodebuild -showsdks | grep -sq visionOS
VISION_OS=$?
set -e

if [[ $VISION_OS == 0 ]]; then
    echo Vision OS available
fi

#build

# BUILT_PRODUCTS_DIR=$BUILD/macosx
# PLATFORM_NAME=macosx
# EFFECTIVE_PLATFORM_NAME=""
# ARCHS="x86_64 arm64"
buildLibrary "macosx" "macosx" "" "x86_64 arm64"
buildLibrary "maccatalyst" "macosx" "-maccatalyst" "x86_64 arm64"
buildLibrary "iphoneos" "iphoneos" "" "arm64"
buildLibrary "iphonesimulator" "iphonesimulator" "-iphonesimulator" "x86_64 arm64"
if [[ $VISION_OS == 0 ]]; then
buildLibrary "xros" "xros" "" "arm64"
buildLibrary "xrsimulator" "xrsimulator" "" "arm64"

xcodebuild -create-xcframework \
-library $BUILD/macosx/lib/libfastrtpsa.a \
-headers $BUILD/macosx/include \
-library $BUILD/iphoneos/lib/libfastrtpsa.a \
-headers $BUILD/iphoneos/include \
-library $BUILD/iphonesimulator/lib/libfastrtpsa.a \
-headers $BUILD/iphonesimulator/include \
-library $BUILD/maccatalyst/lib/libfastrtpsa.a \
-headers $BUILD/maccatalyst/include \
-library $BUILD/xros/lib/libfastrtpsa.a \
-headers $BUILD/xros/include \
-library $BUILD/xrsimulator/lib/libfastrtpsa.a \
-headers $BUILD/xrsimulator/include \
-output $BUILD/FastDDS.xcframework

else

xcodebuild -create-xcframework \
-library $BUILD/macosx/lib/libfastrtpsa.a \
-headers $BUILD/macosx/include \
-library $BUILD/iphoneos/lib/libfastrtpsa.a \
-headers $BUILD/iphoneos/include \
-library $BUILD/iphonesimulator/lib/libfastrtpsa.a \
-headers $BUILD/iphonesimulator/include \
-library $BUILD/maccatalyst/lib/libfastrtpsa.a \
-headers $BUILD/maccatalyst/include \
-output $BUILD/FastDDS.xcframework

fi

XCODE_STRING=$(xcodebuild -version 2>&1| tail -n 2)
XCODE_STRING=${XCODE_STRING//[$'\t\r\n']/ }

XCODE_VER="Archive date:$DATE"
XCODE_VER+=$'\n'
XCODE_VER+="$XCODE_STRING"
echo $XCODE_VER
xczip $BUILD/FastDDS.xcframework --iso-date "$DATE" -o $BUILD/$ZIPNAME -c "$XCODE_VER"
rm -rf $BUILD/FastDDS.xcframework

CHECKSUM=`shasum -a 256 -b $BUILD/$ZIPNAME | awk '{print $1}'`

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

if [[ $3 == "commit" ]]; then

cat >$BUILD/release-note.md << EOL
## Fast-DDS $TAG $ReleaseNote
$XCODE_STRING

#### Supported platforms and architectures
| Platform          |  Architectures     |
|-------------------|--------------------|
| macOS             | x86_64 arm64       |
| iOS               | arm64              |
| iOS Simulator     | x86_64 arm64       |
| Mac Catalyst      | x86_64 arm64       |
EOL

if [[ $VISION_OS == 0 ]]; then

cat >>$BUILD/release-note.md << EOL
| xrOS              | arm64              |
| xrOS Simulator    | arm64              |
EOL

fi

git add Package.swift
git commit -m "Build $TAG"
git tag $TAG
git push
git push --tags
gh release create "$TAG" $BUILD/$ZIPNAME --title "$TAG" --notes-file $BUILD/release-note.md

#
# Cleanup
#
rm -rf $BUILD
git clean -x -d -f
fi
popd > /dev/null
