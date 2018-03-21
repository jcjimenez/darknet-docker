#!/bin/bash
# License: MIT. See license file in root directory
# Copyright(c) JetsonHacks (2017)

set -e

VERSION=3.4.1

cd $HOME
sudo apt-get install -y \
    libglew-dev \
    libtiff5-dev \
    zlib1g-dev \
    libjpeg-dev \
    libpng12-dev \
    libjasper-dev \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libpostproc-dev \
    libswscale-dev \
    libeigen3-dev \
    libtbb-dev \
    libgtk2.0-dev \
    cmake \
    pkg-config

# Python 2.7
sudo apt-get install -y python-dev python-numpy python-py python-pytest -y
# GStreamer support
sudo apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev 

OPENCV_ZIP=opencv-${VERSION}.zip
wget --no-check-certificate -O $OPENCV_ZIP https://github.com/Itseez/opencv/archive/${VERSION}.zip
unzip $OPENCV_ZIP

OPENCV_CONTRIB_ZIP=opencv_contrib-${VERSION}.zip
wget --no-check-certificate -O $OPENCV_CONTRIB_ZIP https://github.com/Itseez/opencv_contrib/archive/${VERSION}.zip
unzip $OPENCV_CONTRIB_ZIP

cd $HOME/opencv-${VERSION}
mkdir build
cd build
# Jetson TX2 
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DBUILD_PNG=OFF \
    -DBUILD_TIFF=OFF \
    -DBUILD_TBB=OFF \
    -DBUILD_JPEG=ON \
    -DBUILD_JASPER=OFF \
    -DBUILD_ZLIB=ON \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_opencv_java=OFF \
    -DBUILD_opencv_python2=ON \
    -DBUILD_opencv_python3=OFF \
    -DENABLE_PRECOMPILED_HEADERS=OFF \
    -DWITH_OPENCL=OFF \
    -DWITH_OPENMP=OFF \
    -DWITH_FFMPEG=ON \
    -DWITH_GSTREAMER=ON \
    -DWITH_GSTREAMER_0_10=OFF \
    -DWITH_CUDA=ON \
    -DWITH_GTK=ON \
    -DWITH_VTK=OFF \
    -DWITH_TBB=ON \
    -DWITH_1394=OFF \
    -DWITH_OPENEXR=OFF \
    -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-9.0 \
    -DCUDA_ARCH_BIN=6.2 \
    -DCUDA_ARCH_PTX="" \
    -DINSTALL_C_EXAMPLES=OFF \
    -DINSTALL_TESTS=OFF \
    -DOPENCV_EXTRA_MODULES_PATH=$HOME/opencv_contrib-${VERSION}/modules \
    ../

# Consider using all 6 cores; $ sudo nvpmodel -m 2 or $ sudo nvpmodel -m 0
make -j4
sudo make install

INSTALL_ARCHIVE=opencv-${VERSION}.tgz
echo Creating $INSTALL_ARCHIVE
tar cfz $INSTALL_ARCHIVE -T install_manifest.txt
 
