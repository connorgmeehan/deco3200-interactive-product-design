# #!/bin/bash

CORE_COUNT=$(nproc --all)
PROJECT_ROOT=$(pwd)
echo Project root is ${PROJECT_ROOT}

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac
echo Running on ${machine}

echo "Building project..."

echo "1.  Building openFrameworks - creative coding toolkit used for webcam processing / display"
echo "1a. Cloning openframeworks 0.10.0..."
wget https://openframeworks.cc/versions/v0.10.1/of_v0.10.1_linux64gcc6_release.tar.gz
mkdir openFrameworks && tar xfz of_v0.10.1_linux64gcc6_release.tar -C openFrameworks --strip-components 1
rm ./of_v0.10.1_linux64gcc6_release.tar.gz
echo "1b. Downloading dependencies"
if [ $machine == Linux ]; then
  echo "  Patching openFrameworks/libs/openFrameworks/utils/ofConstants.h"
  sed -i '212d' ./openFrameworks/libs/openFrameworks/utils/ofConstants.h
  echo "  Patching openFrameworks/addons/ofxOpenCv/src/ofxCvImage.cpp"
  tr 'CV_RGB(' 'cv::Scalar(' < openFrameworks/addons/ofxOpenCv/src/ofxCvImage.cpp
  echo "  Downloading codecs..."# echo "2. Control Center"
  /bin/bash ./openFrameworks/scripts/linux/archlinux/install_codecs.sh
  echo "  Installing globally dependant libraries..."
  /bin/bash ./openFrameworks/scripts/linux/archlinux/install_dependencies.sh
  echo "  Downloading locally dependant libraries..."
  /bin/bash ./openFrameworks/scripts/linux/download_libs.sh
fi
if [ $machine == Mac ]; then 
  /bin/bash ./openFrameworks/scripts/osx/download_libs.sh
fi
echo "1c. Building openFrameworks 0.10.0..."
cd openFrameworks/libs/openFrameworksCompiled/project/
make -j$CORE_COUNT
cd "$PROJECT_ROOT"
echo "1d. Cleaning up unneeded files"
rm -rf ./openFrameworks/apps ./openFrameworks/docs/ ./openFrameworks/examples ./openFrameworks/scripts/templates ./openFrameworks/tests ./openFrameworks/other
echo "1e. DONE!"
cd "$PROJECT_ROOT"

echo "2.  Building opencv3.4 - Computer vision library required to track users"
echo "2a. Cloning opencv 3.4..."
git clone --single-branch --branch 3.4 --depth 1 https://github.com/opencv/opencv.git
echo "2c. Configuring build"
cd opencv
mkdir build
cd build
echo "INSTALL PREFIX: " 
echo "$PROJECT_ROOT/bin/"
cmake -D CMAKE_BUILD_TYPE=Release \
  -D CMAKE_INSTALL_PREFIX="$PROJECT_ROOT/openFrameworks/addons/ofxOpenCv/libs/opencv/" \
  -DOPENCV_GENERATE_PKGCONFIG=OFF \
  -D BUILD_opencv_java=OFF \
  -D BUILD_opencv_python=OFF \
  ..
echo "2b. Building opencv 3.4..."
# make -j 7
echo "2c. Installing opencv 3.4 into ./control_centre/bin/libs"
make install
echo "2d. Copying shared objects to project"
cd "$PROJECT_ROOT"
cp ./openFrameworks/addons/ofxOpenCv/libs/opencv/lib ./control_centre/bin/lib
echo "2e. Replacing ofxOpenCv config makefile to use locally installed openCV version"
cp ./custom_addon_config.mk ./openFrameworks/addons/ofxOpenCv/addon_config.mk
cp -r ./openFrameworks/addons/ofxOpenCv/libs/opencv/lib ./control_centre/bin/lib
echo "2f. DONE!"
cd "$PROJECT_ROOT"

echo "3.  Extensions for main program"
cd openFrameworks/addons/
echo "3a. ofxCv - openFrameworks addon - wrapper for OpenCv..."
echo $(pwd)
git clone --depth 1 https://github.com/kylemcdonald/ofxCv
echo "3b. ofxFaceTracker - openFrameworks addon - Face Tracking library + models (uses ofxCv)..."
echo $(pwd)
git clone --depth 1 https://github.com/kylemcdonald/ofxFaceTracker

echo "3c. ofxFifo - used to send images between control centre and each facial analysis algorithm"
git clone --depth 1 https://github.com/connorgmeehan/ofxFifo
cd "$PROJECT_ROOT"

echo "4. Control Center"
cd control_centre
echo "Building application..."
make -j$CORE_COUNT
echo "DONE!"
cd "$PROJECT_ROOT"

echo "5.  Recogniser"
echo "5a. Building venv (virtual python environment to install modules locally)..."
cd recogniser
python -m venv env
source env/bin/activate

pip install face_recognition
pip install pillow
pip install python-osc
echo "4x. Done, leaving Recogniser environment..."
deactivate
cd "$PROJECT_ROOT"

echo "5. pyasciigen - Converts images into ASCII art"
cd ascii_gen
echo "5a. Cloning asciigen..."
git clone https://github.com/ajalt/pyasciigen
echo "5b. Building virtual environment..."
python -m venv env
source env/bin/activate
echo "5c. Downloading dependencies for virtual environment..."
pip install numpy
pip install pillow
pip install python-osc
echo "5d. Done, leaving pyascii gen environment..."
deactivate

cd "$PROJECT_ROOT"




echo "6. Emotion detector"
echo "6a. Building venv (virtual python environment to install modules locally)..."
cd emotion_detector
python -m venv env
source env/bin/activate
pip install keras numpy 

echo "6b. Done, leaving Emotion detector venv"
deactivate
cd "$PROJECT_ROOT"

echo "6. Demographic detector"
echo "6a. Building venv (virtual python environment to install modules locally)..."
cd demographics
python3.6 -m venv env
source env/bin/activate
pip install -r requirements.txt 
git clone https://github.com/dandynaufaldi/Agendernet
cd Agendernet
patch -p1 < ../patch.diff

echo "6b. Done, leaving Demographic detector venv"
deactivate
cd "$PROJECT_ROOT"

echo "6.  oscP5 communication library for processing..."
echo "6a. Downloading library..."
wget http://www.sojamo.de/libraries/oscP5/download/oscP5-0.9.8.zip
echo "6b. Unziping to project folders..."

declare -a displays=("ascii_display" "face_points")

for i in "${displays[@]}"
do
  echo "$i"
  unzip oscP5*.zip -d "$PROJECT_ROOT/displays/$i"
  rm "$PROJECT_ROOT/displays/$i/INSTALL.txt"
  mkdir "$PROJECT_ROOT/displays/$i/code"
  mv "$PROJECT_ROOT/displays/$i/oscP5/library/oscP5.jar" "$PROJECT_ROOT/displays/$i/code/oscP5.jar"
  mv -v "$PROJECT_ROOT/displays/$i/src" "$PROJECT_ROOT/displays/$i/include"
  rm -r "$PROJECT_ROOT/displays/$i/oscP5"
done
