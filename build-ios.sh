#!/bin/bash
set -e

# Download and setup CMake 3.24.4 (required for OpenCV iOS builds)
if [ ! -d "/tmp/cmake-3.24.4-macos-universal" ]; then
    echo "Downloading CMake 3.24.4..."
    cd /tmp && curl -L -O https://github.com/Kitware/CMake/releases/download/v3.24.4/cmake-3.24.4-macos-universal.tar.gz && tar -xzf cmake-3.24.4-macos-universal.tar.gz
else
    echo "CMake 3.24.4 already exists, skipping download"
fi

# Set CMake 3.24.4 in PATH
export PATH=/tmp/cmake-3.24.4-macos-universal/CMake.app/Contents/bin:$PATH

# Verify CMake version
echo "Using CMake version:"
cmake --version

# Navigate to project directory
cd "$(dirname "$0")"

# Build for iOS arm64 using local (pre-built) OpenCV
echo "Building for iOS arm64..."
python build.py build --ios arm64 --opencv local -vv

echo "Build completed successfully!"
