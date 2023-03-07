#!/bin/bash
################################################
# Function : Install flutter keyboard  
# Desc     : 用于安装flutter APP 控制开发环境                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-02-24 21:25:53                            
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
echo "$(gettext "Install flutter keyboard")"
# https://github.com/Rongix/ros_remote_controller        

#先安装ros1 
echo "Please install ros1 first"

cs -s install_ros1_noetic.sh

#再安装依赖
echo "Install deps"
sudo apt install ros-noetic-joy \
    ros-noetic-teleop-twist-joy \
    ros-noetic-teleop-twist-keyboard \
    ros-noetic-laser-proc \
    ros-noetic-rgbd-launch \
    ros-noetic-depthimage-to-laserscan \
    ros-noetic-rosserial-arduino \
    ros-noetic-rosserial-python \
    ros-noetic-rosserial-server \
    ros-noetic-rosserial-client \
    ros-noetic-rosserial-msgs \
    ros-noetic-amcl \
    ros-noetic-map-server \
    ros-noetic-move-base \
    ros-noetic-urdf \
    ros-noetic-xacro \
    ros-noetic-compressed-image-transport \
    ros-noetic-rqt-image-view \
    ros-noetic-gmapping \
    ros-noetic-navigation \
    ros-noetic-interactive-markers


# 安装turtlebot3
echo "install turtlebot3 simluation"
cs -si install_tb3_noetic_apt.sh

# 安装cv_camera
cs -si install_cv_camera.sh

# rosbridge-server
sudo apt install ros-noetic-rosbridge-server
sudo apt install ros-noetic-web-video-server

# Installation of Node.js
sudo snap install node --classic

# Install node http-server.
npm install http-server

# Grab RosHTTPNavigationMap and run the server
git clone https://github.com/Rongix/RosHTTPNavigationMap.git
