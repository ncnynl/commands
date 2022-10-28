#!/bin/bash
################################################
# Function : install_walking_application.sh                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-07-03 03:06:24                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
        

#install dep 
sudo apt install -y ros-galactic-robot-localization ros-galactic-slam-toolbox
sudo apt install -y ros-galactic-navigation2 \
ros-galactic-nav2-bringup  \
ros-galactic-nav2-controller   \
ros-galactic-nav2-planner  \
ros-galactic-nav2-bt-navigator  \
ros-galactic-nav2-recoveries  \
ros-galactic-nav2-waypoint-follower  \
ros-galactic-nav2-lifecycle-manager \
ros-galactic-behaviortree-cpp-v3 \
ros-galactic-nav2-rviz-plugins

sudo apt install -y ros-galactic-behaviortree-cpp-v3
sudo apt install -y ros-galactic-cartographer-ros
sudo apt install -y ros-galactic-transforms3d
sudo apt install -y ros-galactic-ros2-control ros-galactic-ros2-controllers
sudo apt install -y ros-galactic-navigation2
sudo apt install -y ros-galactic-nav2-bringup
sudo apt install -y ros-galactic-ompl
sudo apt install -y ros-galactic-tf2-tools ros-galactic-tf-transformations
sudo apt install -y ros-galactic-hardware-interface

sudo apt install -y joystick
sudo apt install -y ros-galactic-teleop-twist-keyboard
sudo apt install -y xterm
# 创建工作空间

mkdir -p ~/ros2_walking_app_ws/src

#run 

# cd

cd ~/ros2_walking_app_ws/src

#run 

# git clone

git clone https://gitee.com/ncnynl/walking_application

#run 

# cd

cd ~/ros2_walking_app_ws
rosdep install -i --from-path src --rosdistro galactic -y
#run 

# colcon build

colcon build --symlink-install


#cp model to model
cp -r ~/ros2_walking_app_ws/src/walking_application/models/* ~/.gazebo/models
#run 

# source

echo "source ~/ros2_walking_app_ws/install/setup.bash" >> ~/.bashrc

