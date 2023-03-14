#!/bin/bash
################################################
# Function : Install ORB_SLAMV2 source version
# Desc     : 用于源码方式安装ORB_SLAMV2的脚本                       
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-12-10                          
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ORB_SLAMV2 source version")"

# Tested in ubuntu22.04  opencv 4.5.4
# echo "Not Supported Yet!"
# exit 0  
echo ""
echo "Set workspace"
workspace=tools

echo ""
echo "Set soft name"
soft_name=ORB_SLAM2

echo ""
echo "Workspace if exits ?"
if [ ! -d ~/$workspace ];then 
    mkdir -p ~/$workspace
fi 

echo ""
echo "Software if installed ?"
if [ -d ~/$workspace ];then 
    echo "$soft_name have installed" && exit 0
fi 

echo ""
echo "Install system deps"
# sudo apt-get install libpython2.7-dev libboost-filesystem-dev libboost-dev libboost-thread-dev libglew-dev libblas-dev liblapack-dev
# sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev build-essential

# install Pangolin
echo ""
echo "Download source"
cd ~/$workspace
git clone https://ghproxy.com/https://github.com/stevenlovegrove/Pangolin  Pangolin_orb_slamv2

# 编译代码
echo "Compile source"
cd Pangolin_orb_slamv2
git checkout 25159034e62011b3527228e476cec51f08e87602
sed -i '33a\#include <limits>' ~/tools/Pangolin_orb_slamv2/include/pangolin/gl/colour.h
mkdir build
cd build
cmake -DCPP11_NO_BOOST=1 ..
make

# install ORB_SLAM2
echo ""
echo "Download source"
cd ~/$workspace
git clone https://ghproxy.com/https://github.com/EndlessLoops/ORB_SLAM2

# 编译代码
echo "Compile source"
cd ORB_SLAM2
sudo chmod +x build.sh
./build.sh

echo "Add workspace to bashrc if not exits"
if ! grep -Fq "ORB_SLAM2_ROOT_DIR" ~/.bashrc
then
    echo 'export LD_LIBRARY_PATH=~/tools/Pangolin_orb_slamv2/build/src/:~/tools/ORB_SLAM2/Thirdparty/DBoW2/lib:~/tools/ORB_SLAM2/Thirdparty/g2o/lib:~/tools/ORB_SLAM2/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
    echo 'export ORB_SLAM2_ROOT_DIR=~/tools/ORB_SLAM2' >> ~/.bashrc
    echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi

#How to use
