#!/bin/bash

mkdir deps &> /dev/null
cd deps

#Add necessary extra repos, ONLY For ARM Ubuntu 16.04
# Install CUDA 8.0
wget http://developer.download.nvidia.com/devzone/devcenter/mobile/jetpack_l4t/006/linux-x64/cuda-repo-l4t-8-0-local_8.0.34-1_arm64.deb
sudo dpkg -i cuda-repo-l4t-8-0-local_8.0.34-1_arm64.deb
sudo apt update
sudo apt search cuda 

sudo add-apt-repository universe 
sudo add-apt-repository multiverse
sudo apt-get update

apt install cuda-toolkit-8.0

sudo apt-get install -y cmake-qt-gui git build-essential libusb-1.0-0-dev libudev-dev openjdk-7-jdk freeglut3-dev libglew-dev libsuitesparse-dev libeigen3-dev zlib1g-dev libjpeg-dev

#Installing Pangolin
git clone https://github.com/stevenlovegrove/Pangolin.git
cd Pangolin
mkdir build
cd build
cmake ../ -DAVFORMAT_INCLUDE_DIR="" -DCPP11_NO_BOOST=ON
make -j8
cd ../..

#Up to date OpenNI2
git clone https://github.com/occipital/OpenNI2.git
cd OpenNI2
make -j8
cd ..

#Actually build ElasticFusion
cd ../Core
mkdir build
cd build
cmake ../src
make -j8
cd ../../GPUTest
mkdir build
cd build
cmake ../src
make -j8
cd ../../GUI
mkdir build
cd build
cmake ../src
make -j8
