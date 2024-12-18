#!/bin/bash
################################################
# Function : Install ros2 Omni wheel gazebo car shell  
# Desc     : 源码安装nav2 gps demo脚本    
# Website  : https://www.ncnynl.com/archives/202303/5842.html                   
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2024-09-07                          
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
echo "$(gettext "Install ros2 nav2 gps shell")"
# echo "Not Supported Yet!"
# exit 0  
echo ""
echo "Set workspace"
workspace=ros2_nav2_gps_ws

echo ""
echo "Set soft name"
soft_name=nav2_gps

echo ""

if [ ! -d ~/$workspace ];then 
    mkdir -p ~/$workspace/src
fi 
echo "Software if installed ?"
if [ -d ~/$workspace/src/$soft_name ];then 
    echo "$soft_name have installed" && exit 0
fi 

echo ""
echo "Install system deps"
sudo apt install ros-$ROS_DISTRO-gazebo-ros-pkgs -y
sudo apt install ros-$ROS_DISTRO-ros2-control -y
sudo apt install ros-$ROS_DISTRO-ros2-controllers -y
sudo apt install ros-$ROS_DISTRO-navigation2 -y
sudo apt install ros-$ROS_DISTRO-nav2-bringup -y
sudo apt install ros-$ROS_DISTRO-robot-localization
sudo apt install ros-$ROS_DISTRO-mapviz
sudo apt install ros-$ROS_DISTRO-mapviz-plugins
sudo apt install ros-$ROS_DISTRO-tile-map


# 下载源码
echo ""
echo "Download source"
cd ~/$workspace/src
git clone -b ${ROS_DISTRO} https://gitee.com/ncnynl/nav2_gps

echo ""
echo "Install rosdeps"
cs -si update_rosdep_tsinghua
cd ~/$workspace/
rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y


# 编译代码
echo "Compile source"
cd ~/$workspace/
colcon build --symlink-install 


echo "Add workspace to bashrc if not exits"
if ! grep -Fq "$workspace/install/local_setup.bash" ~/.bashrc
then
    echo ". ~/$workspace/install/local_setup.bash" >> ~/.bashrc
    echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi