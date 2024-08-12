#!/bin/bash
################################################
# Function : Install ros1 four wheel  navigation gazebo car shell  
# Desc     : 源码安装ROS1四轮转向仿真小车的脚本    
# Website  : https://www.ncnynl.com/archives/202303/5841.html                     
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2024-08-03                          
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
echo "$(gettext "Install ros1 four wheel navigation gazebo car shell")"
# echo "Not Supported Yet!"
# exit 0  
echo ""
echo "Set workspace"
workspace=ros1_four_nav_ws

echo ""
echo "Set soft name"
soft_name=commander

echo ""
echo "Software if installed ?"
if [ -d ~/$workspace/src/$soft_name ];then 
    echo "$soft_name have installed" && exit 0
fi 

echo ""
echo "Install system deps"
sudo apt install ros-$ROS_DISTRO-gazebo-ros-pkgs
sudo apt install ros-$ROS_DISTRO-ros-control
sudo apt install ros-$ROS_DISTRO-velocity-controllers


# 下载源码
echo ""
echo "Download source"
cd ~
git clone -b $ROS_DISTRO-nav http://gitee.com/ncnynl/ros1_four_ws $workspace

if [ ! -d ~/$workspace/src/$soft_name ];then 
    echo "$soft_name is not donwloaded" && exit 0
fi 

echo ""
echo "Install rosdeps"
cs -si update_rosdep_tsinghua
cd ~/$workspace/
rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y


# 编译代码
echo "Compile source"
cd ~/$workspace/
catkin_make

# handle model
if [ ! -d ~/.gazebo/models ]; then 
    mkdir -p ~/.gazebo/models
fi

cp -r ~/ros1_four_nav_ws/src/four_ws_stage ~/.gazebo/models/

echo "Add workspace to bashrc if not exits"
if ! grep -Fq "$workspace/devel/setup.bash" ~/.bashrc
then
    echo ". ~/$workspace/devel/setup.bash" >> ~/.bashrc
    echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi

#How to use
