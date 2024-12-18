#!/bin/bash
################################################
# Function : Install barista ros2 source version  
# Desc     : 用于源码方式安装ROS2 humble版车队管理free_fleet_barista的脚本                     
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-12-31                          
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
echo "$(gettext "Install barista ros2 source version")" 

#source from https://bitbucket.org/theconstructcore/barista_ros2_rmf_free_fleet branch:starbots-humble

if [ "$ROS_DISTRO" -ne "humble" ];then 
    echo "This repo just for humble" && exit 0
fi 
echo ""
echo "Set workspace"
workspace=ros2_free_fleet_barista_ws

echo ""
echo "Set soft name"
soft_name=free_fleet_barista

echo ""
echo "Workspace if exits ?"
if [ ! -d ~/$workspace ];then 
    mkdir -p ~/$workspace/src
fi 

echo ""
echo "Software if installed ?"
if [ -d ~/$workspace/src/$soft_name ];then 
    echo "$soft_name have installed" && exit 0
fi 

echo ""
echo "Install system deps"

# 下载源码
echo ""
echo "Download source"
cd ~/$workspace/src
git clone -b humble https://gitee.com/ncnynl/free_fleet_barista 


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

#How to use
