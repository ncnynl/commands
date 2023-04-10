#!/bin/bash
################################################
# Function : Install ROS2 humble turtlebot4 and ignition apt version   
# Desc     : 用于APT方式安装ROS2 humble版ignition仿真及TB4仿真程序的脚本                           
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-07-02 02:39:30                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
# https://raw.githubusercontent.com/turtlebot/turtlebot4_setup/humble/scripts/turtlebot4_setup.sh

export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ROS2 humble turtlebot4 and ignition apt version")"

# echo "Not Yet Supported!" 
# exit 0

#run install dep
echo "Install TurtleBot 4 deps"
sudo apt update
sudo apt install -y  wget python3-colcon-common-extensions python3-rosdep  python3-vcstool ros-dev-tools socat network-manager chrony

# 安装turtlebot
echo "Install TurtleBot 4 Common"
sudo apt install ros-${ROS_DISTRO}-turtlebot4-description \
ros-${ROS_DISTRO}-turtlebot4-msgs \
ros-${ROS_DISTRO}-turtlebot4-setup \
ros-${ROS_DISTRO}-turtlebot4-robot \
ros-${ROS_DISTRO}-irobot-create-control \
ros-${ROS_DISTRO}-turtlebot4-navigation \
ros-${ROS_DISTRO}-turtlebot4-node

echo "Install TurtleBot 4 Desktop"
sudo apt install ros-${ROS_DISTRO}-turtlebot4-desktop

echo "Install RPLIDAR A1M8"
sudo apt install ros-${ROS_DISTRO}-rplidar-ros

echo "Install OAK-D"
sudo apt install ros-${ROS_DISTRO}-depthai-ros

