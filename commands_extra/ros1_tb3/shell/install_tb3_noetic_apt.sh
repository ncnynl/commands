#!/bin/bash
################################################
# Function : Install turtlebot3 ROS1 noetic apt
# Desc     : 用于APT方式安装ROS1版本Turtlebot3的脚本                                
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
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install turtlebot3 ROS1 noetic apt")"

#instal dep
sudo apt-get install -y ros-noetic-joy ros-noetic-teleop-twist-joy \
  ros-noetic-teleop-twist-keyboard ros-noetic-laser-proc \
  ros-noetic-rgbd-launch ros-noetic-rosserial-arduino \
  ros-noetic-rosserial-python ros-noetic-rosserial-client \
  ros-noetic-rosserial-msgs ros-noetic-amcl ros-noetic-map-server \
  ros-noetic-move-base ros-noetic-urdf ros-noetic-xacro \
  ros-noetic-compressed-image-transport ros-noetic-rqt* ros-noetic-rviz \
  ros-noetic-gmapping ros-noetic-navigation ros-noetic-interactive-markers

#gmapping
sudo apt install ros-noetic-slam-gmapping -y
#karto
sudo apt install ros-noetic-slam-karto -y 
#hector
sudo apt install ros-noetic-hector-slam -y
#cartographer/source install

#install turtlebot3
sudo apt install -y ros-noetic-dynamixel-sdk
sudo apt install -y ros-noetic-turtlebot3-msgs
sudo apt install -y ros-noetic-turtlebot3
sudo apt install -y ros-noetic-turtlebot3-gazebo
sudo apt install -y ros-noetic-turtlebot3-fake


# export GAZEBO_MODEL_PATH
# echo 'export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:~/ros1_tb3_ws/src/turtlebot3/turtlebot3_simulations/turtlebot3_gazebo/models' >> ~/.bashrc

# export TURTLEBOT3_MODEL
if ! grep -Fq "TURTLEBOT3_MODEL" ~/.bashrc
then
  echo 'export TURTLEBOT3_MODEL=burger' >> ~/.bashrc
fi