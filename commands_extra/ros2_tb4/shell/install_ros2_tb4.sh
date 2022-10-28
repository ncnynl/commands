#!/bin/bash
################################################
# Function : install_ros2_tb4.sh                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-07-06 16:19:08                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
        

#run 

# install ros-galactic-turtlebot4

sudo apt update
sudo apt install ros-galactic-turtlebot4-description \
ros-galactic-turtlebot4-msgs \
ros-galactic-turtlebot4-navigation \
ros-galactic-turtlebot4-node

#run 

# install ros-galactic-turtlebot4-robot

sudo apt install ros-galactic-turtlebot4-robot

#run 

# 

sudo apt install ros-galactic-turtlebot4-desktop

#run 

# install dep

sudo apt install -y \
python3-colcon-common-extensions \
python3-rosdep \
python3-vcstool

#run 

# install ros-galactic-turtlebot4-simulator

sudo apt install ros-galactic-turtlebot4-simulator ros-galactic-irobot-create-nodes

