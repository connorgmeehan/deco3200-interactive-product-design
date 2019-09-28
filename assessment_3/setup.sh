#!/bin/bash

PROJECT_ROOT=$(pwd)
echo "Building project..."
echo "1. libfacedetection"
echo "1a. Cloning libfacedetection"
git clone https://github.com/ShiqiYu/libfacedetection
cd libfacedetection
echo "1b. Building libfacedetection"
mkdir build && cd build && cmake -DENABLE_AVX2=ON -DENABLE_INT8=ON -DCMAKE_EXE_LINKER_FLAGS='-static-libstdc++' .. && make
cd "$PROJECT_ROOT"
echo "1c. Copying header to ./src/libs/libfacedetectioncnn.h"
cp ./libfacedetection/src/facedetectcnn.h ./src/libs/facedetectcnn.h
echo "1d. Copying shared libraries to ./bin/libs/libfacedetection"
cp ./libfacedetection/build/libfacedetection.so ./bin/libs/libfacedetection.so
cp ./libfacedetection/build/libfacedetection.a ./bin/libs/libfacedetection.a
echo "DONE!"


echo "2. Control Center"
echo "Building application..."
make -j4
echo "DONE!"
