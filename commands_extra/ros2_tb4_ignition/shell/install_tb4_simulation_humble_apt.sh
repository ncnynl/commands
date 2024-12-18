#!/bin/bash
################################################
# Function : Install ROS2 turtlebot4 simulation humble apt version   
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
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ROS2 turtlebot4 simulation humble apt version")"

# echo "Not Yet Supported!" 
# exit 0

#run install dep

#  安装依赖

sudo apt install -y  wget python3-colcon-common-extensions python3-rosdep  python3-vcstool

#run add gazebo source

# 添加gazebo源

sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'

#run add gazebo key

#  添加gazebo key

wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -

#run install ignition

# 安装ignition-edifice

sudo apt-get update && sudo apt-get install ignition-fortress

# 安装turtlebot4_simulator
sudo apt install ros-${ROS_DISTRO}-turtlebot4-simulator ros-${ROS_DISTRO}-irobot-create-nodes