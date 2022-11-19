#!/bin/bash
################################################
# Function : install_turtlebot3_ros2_galactic.sh                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-06-30 15:25:09                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
#run ros2_tb3_ws

echo "apt install turtlebot3 on ros2 humble"
sudo apt install ros-humble-turtlebot3-fake-node ros-humble-turtlebot3-example 
sudo apt install ros-humble-turtlebot3-cartographer ros-humble-turtlebot3-bringup 
sudo apt install ros-humble-turtlebot3-simulations ros-humble-turtlebot3-navigation2 ros-humble-turtlebot3-gazebo 
sudo apt install ros-humble-turtlebot3-description ros-humble-turtlebot3-teleop 
