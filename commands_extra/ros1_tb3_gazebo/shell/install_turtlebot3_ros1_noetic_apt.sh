#!/bin/bash
################################################
# Function : install_turtlebot3_ros1_noetic_apt.sh                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-07-05 01:50:53                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################

#instal dep
sudo apt-get install -y ros-noetic-joy ros-noetic-teleop-twist-joy \
  ros-noetic-teleop-twist-keyboard ros-noetic-laser-proc \
  ros-noetic-rgbd-launch ros-noetic-rosserial-arduino \
  ros-noetic-rosserial-python ros-noetic-rosserial-client \
  ros-noetic-rosserial-msgs ros-noetic-amcl ros-noetic-map-server \
  ros-noetic-move-base ros-noetic-urdf ros-noetic-xacro \
  ros-noetic-compressed-image-transport ros-noetic-rqt* ros-noetic-rviz \
  ros-noetic-gmapping ros-noetic-navigation ros-noetic-interactive-markers


#install turtlebot3
sudo apt install -y ros-noetic-dynamixel-sdk
sudo apt install -y ros-noetic-turtlebot3-msgs
sudo apt install -y ros-noetic-turtlebot3
sudo apt install -y ros-noetic-turtlebot3-gazebo
sudo apt install -y ros-noetic-turtlebot3-fake


# export GAZEBO_MODEL_PATH
echo 'export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:~/ros1_tb3_ws/src/turtlebot3/turtlebot3_simulations/turtlebot3_gazebo/models' >> ~/.bashrc

# export TURTLEBOT3_MODEL
echo 'export TURTLEBOT3_MODEL=burger' >> ~/.bashrc