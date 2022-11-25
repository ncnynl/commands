#!/bin/bash
################################################################
# Function :Install ROS1 Noetic                                #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-06-23                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################


if [ -d /opt/ros/noetic ]; then
    echo "ros1 noetic have installed!!" 
else

    ros1_distro=noetic

    echo "Start to install ROS1 $ros1_distro"

    # Install ROS 1
    sudo apt update && sudo apt install -y curl gnupg2 lsb-release

    # Add ros source
    sudo sh -c 'echo "deb http://mirrors.aliyun.com/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
    sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
    sudo apt update
    sudo apt install -y ros-$ros1_distro-desktop-full

    # Install ROS 1 build tools
    sudo apt install -y python3-rosdep python3-rosinstall-generator python3-vcstool build-essential

    #add ros to bashrc
    sudo echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

    echo "ROS $ros1_distro installed successfully"

fi