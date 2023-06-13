#!/bin/bash
################################################################
# Function :Install ROS1 Noetic ORB_SLAM2                      #
# Desc     : 用于源码方式安装ROS1 Noetic版本自主探索建图算法frontier_exploration的脚本
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-11-30                                         #
# Author   :ncnynl EndlessLoops                                #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ROS1 Noetic frontier_exploration")"

workspace=ros1_algorithm_ws

if [ -d ~/$workspace/src/frontier_exploration ]; then
    echo "frontier_exploration have installed!!" 
else
    if [ ! -d ~/$workspace/ ];then
        mkdir -p ~/$workspace/src
    fi

    ## isntall lib
    sudo apt update
    sudo apt install ros-noetic-costmap-2d ros-noetic-move-base-msgs

    ## install frontier_exploration
    cd ~/$workspace/src
    git clone -b melodic-devel https://ghproxy.com/https://github.com/paulbovbel/frontier_exploration
    rosdep update
    rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y    
    cd ~/$workspace && catkin_make

     #add to bashrc if not exits
    if ! grep -Fq "$workspace" ~/.bashrc
    then
        echo "export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:$HOME/$workspace/devel/setup.bash" >> ~/.bashrc
        echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
        
    else
        echo "Has been inited before! Please check ~/.bashrc"
    fi

    echo "ROS frontier_exploration installed successfully"
fi


