#!/bin/bash
################################################
# Function : install_tb4_ignition_humble_apt.sh                              
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
#还不支持apt安装

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

#run update

# 更新软件源

sudo apt update

#run install turtlebot4 simulator

# 安装turtlebot4_simulator

sudo apt install ros-humble-turtlebot4-simulator ros-humble-irobot-create-nodes

