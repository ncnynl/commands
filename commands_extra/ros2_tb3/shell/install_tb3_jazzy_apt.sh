#!/bin/bash
################################################################
# Function :Install ROS2 jazzy turtlebot3 apt version       
# Desc     : 用于APT方式安装ROS2 jazzy版Turtlebot3的脚本
# Website  : https://www.ncnynl.com/archives/202210/5574.html
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2022-07-08                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://ncnynl.com                                      
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ROS2 jazzy turtlebot3 apt version")"

ros2_distro=jazzy

echo "Start to install turtlebot3 ROS2 $ros2_distro version"

sudo apt install -y ros-$ros2_distro-turtlebot3 ros-$ros2_distro-turtlebot3-bringup ros-$ros2_distro-turtlebot3-simulations ros-$ros2_distro-turtlebot3-teleop ros-$ros2_distro-turtlebot3-example

echo "ROS 2 $ros2_distro installed successfully"
