#!/bin/bash
#
# fastrtps_build_apple.sh
# Copyright © 2020 Dmitriy Borovikov. All rights reserved.
#
set -e
set -x
echo $PLATFORM_NAME$EFFECTIVE_PLATFORM_NAME $ARCHS

if [ -f "$BUILT_PRODUCTS_DIR/lib/libfastrtpsa.a" ]; then
echo Already build "$BUILT_PRODUCTS_DIR/lib/libfastrtpsa.a"
exit 0
fi
#export CMAKE_BUILD_PARALLEL_LEVEL=$(sysctl hw.ncpu | awk '{print $2}')

rm -rf "$PROJECT_TEMP_DIR"
if [ "$PLATFORM_NAME" = "macosx" ]; then
  if [ "$EFFECTIVE_PLATFORM_NAME" = "-maccatalyst" ]; then
cmake -S$SOURCE_DIR/memory -B"$PROJECT_TEMP_DIR/memory" \
-D CMAKE_INSTALL_PREFIX="$BUILT_PRODUCTS_DIR" \
-D CMAKE_TOOLCHAIN_FILE=$ROOT_PATH/script/cmake/maccatalyst.toolchain.cmake \
-D FOONATHAN_MEMORY_BUILD_EXAMPLES=OFF \
-D FOONATHAN_MEMORY_BUILD_TESTS=OFF \
-D FOONATHAN_MEMORY_BUILD_TOOLS=OFF \
-D CMAKE_DEBUG_POSTFIX="" \
-D CMAKE_OSX_DEPLOYMENT_TARGET="10.15" \
-D CMAKE_XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET="13.1" \
-D CMAKE_CONFIGURATION_TYPES=Release \
-G Xcode

xcodebuild build -scheme install -destination 'generic/platform=macOS,variant=Mac Catalyst' -project "$PROJECT_TEMP_DIR/memory/FOONATHAN_MEMORY.xcodeproj"

cmake -S$SOURCE_DIR/Fast-DDS -B"$PROJECT_TEMP_DIR/Fast-DDS" \
-D CMAKE_INSTALL_PREFIX="$BUILT_PRODUCTS_DIR" \
-D CMAKE_TOOLCHAIN_FILE="$ROOT_PATH/script/cmake/maccatalyst.toolchain.cmake" \
-D foonathan_memory_DIR="$BUILT_PRODUCTS_DIR/share/foonathan_memory/cmake" \
-D SQLITE3_SUPPORT=OFF \
-D THIRDPARTY=ON \
-D COMPILE_EXAMPLES=OFF \
-D BUILD_DOCUMENTATION=OFF \
-D BUILD_SHARED_LIBS=OFF \
-D CMAKE_OSX_DEPLOYMENT_TARGET="10.15" \
-D CMAKE_XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET="13.1" \
-D CMAKE_CONFIGURATION_TYPES=Release \
-G Xcode

xcodebuild build -scheme install -destination 'generic/platform=macOS,variant=Mac Catalyst' -project "$PROJECT_TEMP_DIR/Fast-DDS/fastrtps.xcodeproj"

  else
cmake -S$SOURCE_DIR/memory -B"$PROJECT_TEMP_DIR/memory" \
-D CMAKE_INSTALL_PREFIX="$BUILT_PRODUCTS_DIR" \
-D FOONATHAN_MEMORY_BUILD_EXAMPLES=OFF \
-D FOONATHAN_MEMORY_BUILD_TESTS=OFF \
-D FOONATHAN_MEMORY_BUILD_TOOLS=ON \
-D CMAKE_DEBUG_POSTFIX="" \
-D CMAKE_OSX_DEPLOYMENT_TARGET="10.10" \
-D CMAKE_OSX_ARCHITECTURES="$ARCHS" \
-D CMAKE_CONFIGURATION_TYPES=Release \
-G Xcode
cmake --build "$PROJECT_TEMP_DIR/memory" --config Release --target install

cmake -S$SOURCE_DIR/Fast-DDS -B"$PROJECT_TEMP_DIR/Fast-DDS" \
-D CMAKE_INSTALL_PREFIX="$BUILT_PRODUCTS_DIR" \
-D foonathan_memory_DIR="$BUILT_PRODUCTS_DIR/share/foonathan_memory/cmake" \
-D SQLITE3_SUPPORT=OFF \
-D THIRDPARTY=ON \
-D COMPILE_EXAMPLES=OFF \
-D BUILD_DOCUMENTATION=OFF \
-D BUILD_SHARED_LIBS=OFF \
-D CMAKE_OSX_DEPLOYMENT_TARGET="10.10" \
-D CMAKE_OSX_ARCHITECTURES="$ARCHS" \
-D CMAKE_CONFIGURATION_TYPES=Release \
-G Xcode

cmake --build "$PROJECT_TEMP_DIR/Fast-DDS" --config Release --target install

  fi
fi

if [ "$PLATFORM_NAME" = "iphoneos" ] || [ "$PLATFORM_NAME" = "iphonesimulator" ]; then
export IPHONEOS_DEPLOYMENT_TARGET="9.0"
cmake -S$SOURCE_DIR/memory -B"$PROJECT_TEMP_DIR/memory" \
-D CMAKE_TOOLCHAIN_FILE="$ROOT_PATH/script/cmake/ios.toolchain.cmake" \
-D CMAKE_INSTALL_PREFIX="$BUILT_PRODUCTS_DIR" \
-D CMAKE_CONFIGURATION_TYPES=Release \
-D CMAKE_C_COMPILER=clang \
-D CMAKE_CXX_COMPILER=clang++ \
-D CMAKE_XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET=$IPHONEOS_DEPLOYMENT_TARGET \
-D CMAKE_DEBUG_POSTFIX="" \
-D FOONATHAN_MEMORY_BUILD_EXAMPLES=OFF \
-D FOONATHAN_MEMORY_BUILD_TESTS=OFF \
-D FOONATHAN_MEMORY_BUILD_TOOLS=OFF \
-G Xcode

cmake --build "$PROJECT_TEMP_DIR/memory" --config Release --target install --

cmake -S$SOURCE_DIR/Fast-DDS -B"$PROJECT_TEMP_DIR/Fast-DDS" \
-D CMAKE_TOOLCHAIN_FILE="$ROOT_PATH/script/cmake/ios.toolchain.cmake" \
-D CMAKE_CONFIGURATION_TYPES=Release \
-D CMAKE_C_COMPILER=clang \
-D CMAKE_CXX_COMPILER=clang++ \
-D CMAKE_XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET=$IPHONEOS_DEPLOYMENT_TARGET \
-D BUILD_SHARED_LIBS=NO \
-D CMAKE_INSTALL_PREFIX="$BUILT_PRODUCTS_DIR" \
-D foonathan_memory_DIR="$BUILT_PRODUCTS_DIR/foonathan_memory/cmake" \
-D SQLITE3_SUPPORT=OFF \
-D THIRDPARTY=ON \
-D COMPILE_EXAMPLES=OFF \
-D BUILD_DOCUMENTATION=OFF \
-G Xcode

cmake --build "$PROJECT_TEMP_DIR/Fast-DDS" --config Release --target install --
fi
rm -rf "$PROJECT_TEMP_DIR"

cd "$BUILT_PRODUCTS_DIR/lib"
libtool -static -o libfastrtpsa.a libfastrtps.a libfastcdr.a libfoonathan_memory-0.6.2.a
