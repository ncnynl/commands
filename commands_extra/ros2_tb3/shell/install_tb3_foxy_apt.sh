#!/bin/bash
################################################################
# Function :Install ROS2 Foxy                                #
# Desc     : 用于APT方式安装ROS2 Foxy版Turtlebot3的脚本  
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-07-08                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################

ros2_distro=foxy

echo "Start to install turtlebot3 ROS2 $ros2_distro version"

sudo apt install -y ros-$ros2_distro-turtlebot3 ros-$ros2_distro-turtlebot3-bringup ros-$ros2_distro-turtlebot3-simulations ros-$ros2_distro-turtlebot3-teleop ros-$ros2_distro-turtlebot3-example

echo "ROS 2 $ros2_distro installed successfully"
