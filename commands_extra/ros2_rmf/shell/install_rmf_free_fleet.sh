#!/bin/bash
################################################
# Function : install ros2 rmf web 22.04 
# Desc     : 用于源码方式安装ROS2 humble版FreeFLeet的脚本
# Website  : https://www.ncnynl.com/archives/202212/5777.html
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-07-06 18:22:04                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
# https://github.com/open-rmf/free_fleet
# echo "Not Yet Supported!"
# exit 0        
#基于ubuntu22.04
#安装依赖 

if [ -d ~/ros2_free_fleet_ws ]; then 
  echo "free_fleet have installed!"
  exit 0
fi


sudo apt update && sudo apt install \
  git wget  qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools \
  python3-rosdep \
  python3-vcstool \
  python3-colcon-common-extensions \
  # maven default-jdk   # Uncomment to install dependencies for message generation

#install qt5
# sudo apt install  -y qt5-default  not support on ubuntu22.04
# replace to qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools  

#cyclonedds-tools dds_idlc
# sudo apt install cyclonedds-tools


#downlaod
mkdir -p ~/ros2_free_fleet_ws/src
cd ~/ros2_free_fleet_ws/src
#commit 4f2c897b206d55905f51222499cde5dd36a4c093
git clone -b main https://ghproxy.com/https://github.com/open-rmf/free_fleet
#have installed in rmf
# git clone -b main https://ghproxy.com/https://github.com/open-rmf/rmf_internal_msgs 

#for humble need fix from differential to nav2_amcl::DifferentialMotionModel
if [ ${ROS_DISTRO} == "humble" ]; then
  sed -i 's/differential/nav2_amcl::DifferentialMotionModel/'g ~/ros2_free_fleet_ws/src/free_fleet/ff_examples_ros2/params/turtlebot3_world_burger.yaml
  sed -i 's/differential/nav2_amcl::DifferentialMotionModel/'g ~/ros2_free_fleet_ws/src/free_fleet/ff_examples_ros2/params/turtlebot3_world_waffle_pi.yaml
  sed -i 's/differential/nav2_amcl::DifferentialMotionModel/'g ~/ros2_free_fleet_ws/src/free_fleet/ff_examples_ros2/params/turtlebot3_world_waffle.yaml
fi
#rosdep
cd ~/ros2_free_fleet_ws/
rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y

#build for ros2
colcon build --packages-up-to \
  free_fleet ff_examples_ros2 free_fleet_server_ros2 free_fleet_client_ros2
