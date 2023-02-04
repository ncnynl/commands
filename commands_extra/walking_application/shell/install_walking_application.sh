#!/bin/bash
################################################
# Function : install walking application     
# Desc     : 用于源码方式安装ROS2版仿真软件walking application的脚本 
# Website  : https://www.ncnynl.com/archives/202212/5761.html                         
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
        
workspace=ros2_walking_app_ws

echo $ROS_DISTRO;

if [ "galactic" != "$ROS_DISTRO" ] 
then 
    echo "This repo just for galactic" && exit 0
fi 
# 创建工作空间
echo "workspace if exits ?"
if [ ! -d ~/$workspace ];then 
    mkdir -p ~/$workspace/src
fi 

echo "software if installed ?"
if [ -d ~/$workspace/src/walking_application ];then 
    echo "walking_application have installed" && exit 0
fi 

echo "install rosdeps"
sudo apt install -y ros-${ROS_DISTRO}-robot-localization ros-${ROS_DISTRO}-slam-toolbox
sudo apt install -y ros-${ROS_DISTRO}-navigation2 \
ros-${ROS_DISTRO}-nav2-bringup  \
ros-${ROS_DISTRO}-nav2-controller   \
ros-${ROS_DISTRO}-nav2-planner  \
ros-${ROS_DISTRO}-nav2-bt-navigator  \
ros-${ROS_DISTRO}-nav2-recoveries  \
ros-${ROS_DISTRO}-nav2-waypoint-follower  \
ros-${ROS_DISTRO}-nav2-lifecycle-manager \
ros-${ROS_DISTRO}-behaviortree-cpp-v3 \
ros-${ROS_DISTRO}-nav2-rviz-plugins

sudo apt install -y ros-${ROS_DISTRO}-behaviortree-cpp-v3
sudo apt install -y ros-${ROS_DISTRO}-cartographer-ros
sudo apt install -y ros-${ROS_DISTRO}-transforms3d
sudo apt install -y ros-${ROS_DISTRO}-ros2-control ros-${ROS_DISTRO}-ros2-controllers
sudo apt install -y ros-${ROS_DISTRO}-navigation2
sudo apt install -y ros-${ROS_DISTRO}-nav2-bringup
sudo apt install -y ros-${ROS_DISTRO}-ompl
sudo apt install -y ros-${ROS_DISTRO}-tf2-tools ros-${ROS_DISTRO}-tf-transformations
sudo apt install -y ros-${ROS_DISTRO}-hardware-interface

sudo apt install -y joystick
sudo apt install -y ros-${ROS_DISTRO}-teleop-twist-keyboard
sudo apt install -y xterm


echo "Download source"
cd ~/$workspace/src 
git clone -b ${ROS_DISTRO} https://gitee.com/ncnynl/walking_application

# 编译代码
echo "Compile source"
cd ~/$workspace/
rosdep install -i --from-path src --rosdistro ${ROS_DISTRO} -y
colcon build --symlink-install


#cp model to model
cp -r ~/$workspace/src/walking_application/models/* ~/.gazebo/models
#run 

# source
if ! grep -Fq "$workspace/install/local_setup.bash" ~/.bashrc
then
    echo ". ~/$workspace/install/local_setup.bash" >> ~/.bashrc
    echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi

