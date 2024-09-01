#!/bin/bash
################################################
# Function : Install ros2 clearpath gazebo shell  
# Desc     : 源码安装clearpath仿真的脚本    
# Website  : https://docs.clearpathrobotics.com/docs/ros/tutorials/simulator/install                 
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2024-08-31                          
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ros2 clearpath gazebo shell")"
# echo "Not Supported Yet!"
# exit 0  
echo ""
echo "Set workspace"
workspace=ros2_clearpath_ws

echo ""
echo "Set soft name"
soft_name=clearpath_simulator

if [ ! -d ~/$workspace/src ] ; then 
    mkdir -p ~/$workspace/src/
fi

echo ""
echo "Software if installed ?"
if [ -d ~/$workspace/src/$soft_name ];then 
    echo "$soft_name have installed" && exit 0
fi 

echo ""
echo "Install system deps"
sudo apt-get update

sudo apt install ros-${ROS_DISTRO}-gazebo-ros-pkgs
sudo apt install ros-${ROS_DISTRO}-ros2-control
sudo apt install ros-${ROS_DISTRO}-ros2-controllers
sudo apt-get install ros-${ROS_DISTRO}-clearpath-nav2-demos
sudo apt-get install ros-${ROS_DISTRO}-realsense2-camera
# 下载源码
echo ""
echo "Download source"
cd ~/$workspace/src
git clone -b main https://github.com/clearpathrobotics/clearpath_simulator
git clone -b ${ROS_DISTRO} https://github.com/clearpathrobotics/clearpath_common.git
git clone -b main https://github.com/clearpathrobotics/clearpath_config.git
git clone -b main https://github.com/clearpathrobotics/clearpath_msgs.git


if [ ! -d ~/$workspace/src/$soft_name ];then 
    echo "Download failed, please try again!" && exit 0
fi

echo ""
echo "Install rosdeps"
cs -si update_rosdep_tsinghua
cd ~/$workspace/
rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y


# 编译代码
echo "Compile source"
cd ~/$workspace/
colcon build --symlink-install 

if [ ! -d ~/clearpath ]; then 
    mkdir ~/clearpath
fi 


echo "Add workspace to bashrc if not exits"
if ! grep -Fq "$workspace/install/local_setup.bash" ~/.bashrc
then
    echo ". ~/$workspace/install/local_setup.bash" >> ~/.bashrc
    echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi

#How to use
# ros2 launch clearpath_gz simulation.launch.py
# https://docs.clearpathrobotics.com/docs/ros/tutorials/simulator/simulate
# https://clearpathrobotics.com/assets/guides/foxy/jackal/JackalSimulation.html