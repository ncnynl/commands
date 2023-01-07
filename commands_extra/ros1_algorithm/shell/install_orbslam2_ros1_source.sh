#!/bin/bash
################################################################
# Function :Install ROS1 Noetic ORB_SLAM2                      #
# Desc     : 用于源码方式安装ROS1版本视觉建图算法ORB_SLAM2的脚本
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-11-30                                         #
# Author   :ncnynl EndlessLoops                                #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################

workspace=ros1_vslam_ws

if [ -d ~/$workspace/ORB_SLAM2 ]; then
    echo "ORB_SLAM2 have installed!!" 
else
    if [ ! -d ~/$workspace/ ];then
        mkdir -p ~/$workspace/
    fi
    ## isntall lib
    sudo apt-get update
    sudo apt-get install libpython2.7-dev libboost-filesystem-dev libboost-dev libboost-thread-dev libglew-dev libblas-dev liblapack-dev
    sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev build-essential 

    ## install Pangolin
    cd ~/$workspace/
    git clone https://ghproxy.com/https://github.com/stevenlovegrove/Pangolin
    cd ~/$workspace/Pangolin
    git checkout 25159034e62011b3527228e476cec51f08e87602
    mkdir build
    cd build
    cmake -DCPP11_NO_BOOST=1 ..
    make

    ## install ORB_SLAM2/
    cd ~/$workspace/
    git clone -b noetic https://gitee.com/ncnynl/ORB_SLAM2/
    cd ~/$workspace/ORB_SLAM2
    chmod +x build.sh build_ros.sh
    ./build.sh
    #echo "ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:~/ros1_vslam_ws/ORB_SLAM2/Examples/ROS" >> ~/.bashrc
   


    #add to bashrc if not exits
    if ! grep -Fq "$workspace/ORB_SLAM2/Examples/ROS" ~/.bashrc
    then
        echo "ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:$HOME/ros1_vslam_ws/ORB_SLAM2/Examples/ROS" >> ~/.bashrc
        echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
    else
        echo "Has been inited before! Please check ~/.bashrc"
    fi    
    ./build_ros.sh

    echo "ROS ${ROS_DISTRO} ORB_SLAM2 installed successfully"
fi


