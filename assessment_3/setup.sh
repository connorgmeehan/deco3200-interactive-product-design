#!/bin/bash

PROJECT_ROOT=$(pwd)
echo "Building project..."
echo "1.  Building opencv3.4 - Computer vision library required to track users"
echo "1a. Cloning opencv 3.4..."
git clone --single-branch --branch 3.4 --depth 1 https://github.com/opencv/opencv.git
echo "1c. Configuring build"
cd opencv
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=Release \
  -D CMAKE_INSTALL_PREFIX="$(PROJECT_ROOT)/bin/"\
  -DOPENCV_GENERATE_PKGCONFIG=ON \
  -D BUILD_opencv_java=OFF \
  -D BUILD_opencv_python=OFF \
  ..
echo "1b. Building opencv 3.4..."
make -j 4
echo "1c. Installing opencv 3.4 into ./bin/libs"
make install
echo "1d. DONE!"
cd "$PROJECT_ROOT"

echo "2.  Building openFrameworks - creative coding toolkit used for webcam processing / display"
echo "2a. Cloning openframeworks 0.10.0..."
echo $(pwd)
git clone --single-branch --branch 0.10.0 --depth 1 https://github.com/openframeworks/openFrameworks.git
echo "2b. Building openFrameworks 0.10.0..."
make openFrameworks/libs/openFrameworksCompiled/project/ -j 4
echo "2c. DONE!"

echo "3.  Extensions for main program"
cd openFrameworks/addons/
echo "3a. ofxCv - openFrameworks addon - wrapper for OpenCv..."
echo $(pwd)
git clone --depth 1 https://github.com/kylemcdonald/ofxCv
echo "3b. ofxFaceTracker - openFrameworks addon - Face Tracking library + models (uses ofxCv)..."
echo $(pwd)
git clone --depth 1 https://github.com/kylemcdonald/ofxFaceTracker

echo "2. Control Center"
echo "Building application..."
make -j4
echo "DONE!"
