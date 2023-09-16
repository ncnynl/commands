#!/bin/bash
################################################################
# Function :Install ROS1 Noetic ORB_SLAM2                      
# Desc     : 用于源码方式安装ROS1版本单目视觉建图算法DSO的脚本
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2022-11-30                                         
# Author   :ncnynl EndlessLoops                                
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://ncnynl.com                                      
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ROS1 Noetic ORB_SLAM2")"

workspace=ros1_vslam_ws

if [ -d ~/$workspace/dso ]; then
    echo -e "\033[33m DSO have installed! \033[0m"

else
    if [ ! -d ~/$workspace/ ];then
        mkdir ~/$workspace/
    fi
    ## isntall lib
    sudo apt-get update
    sudo apt-get install libsuitesparse-dev libeigen3-dev libboost-all-dev


    ## install Pangolin
    if [ -d ~/$workspace/Pangolin ];then
        echo -e "\033[33m Pangolin have installed!! \033[0m"
    else
        echo -e "\033[33m Now installing Pangolin. \033[0m"
     
        cd ~/$workspace/
        git clone https://ghproxy.com/https://github.com/stevenlovegrove/Pangolin
        cd ~/$workspace/Pangolin
        git checkout 25159034e62011b3527228e476cec51f08e87602
        mkdir build
        cd build
        cmake -DCPP11_NO_BOOST=1 ..
        make
    fi

    ## install libzip
    echo -e "\033[33m Now installing libzip. \033[0m"

    cd ~/$workspace/
    git clone https://ghproxy.com/https://github.com/JakobEngel/dso.git

    sudo apt-get install zlib1g-dev
    cd ~/$workspace/dso/thirdparty
    tar -zxvf libzip-1.1.1.tar.gz
    cd libzip-1.1.1/
    ./configure
    make
    sudo make install

    ## install DSO
    echo -e "\033[33m Now installing dso. \033[0m"
    cd ~/$workspace/dso
    sed -i 's/CV_LOAD_IMAGE_GRAYSCALE/cv::IMREAD_GRAYSCALE/'g ~/$workspace/dso/src/IOWrapper/OpenCV/ImageRW_OpenCV.cpp
    sed -i 's/CV_LOAD_IMAGE_COLOR/cv::IMREAD_COLOR/'g ~/$workspace/dso/src/IOWrapper/OpenCV/ImageRW_OpenCV.cpp
    sed -i 's/CV_LOAD_IMAGE_UNCHANGED/cv::IMREAD_UNCHANGED/'g ~/$workspace/dso/src/IOWrapper/OpenCV/ImageRW_OpenCV.cpp    
    mkdir build
    cd build
    cmake ..
    make -j    

    ## install DSO_ROS
    echo -e "\033[33m Now installing dso_ros. \033[0m"
    export DSO_PATH=~/$workspace/dso
    if [ ! -d ~/$workspace/src ];then
        mkdir -p ~/$workspace/src
    fi
    cd ~/$workspace/src
    git clone -b catkin https://ghproxy.com/https://github.com/JakobEngel/dso_ros
    cd ..
    catkin_make

    ## add to bashrc if not exits
    if ! grep -Fq "source ~/$workspace/devel/setup.bash" ~/.bashrc
    then
        echo "source ~/$workspace/devel/setup.bash" >> ~/.bashrc
        echo -e "\033[33m $workspace workspace have installed successfully! writed to ~/.bashrc \033[0m"

    else
        echo -e "\033[33m Has been inited before! Please check ~/.bashrc \033[0m"
    fi

    echo -e "\033[33m ROS ${ROS_DISTRO} DSO installed successfully \033[0m"
fi


