#!/bin/bash
################################################
# Function : Install walking_rviz_plugins source version 
# Desc     : 用于源码方式安装walking_rviz_plugins程序的脚本                           
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-07-02 02:39:30                            
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
echo "$(gettext "Install walking_rviz_plugins source version")"

echo ""
echo "Set workspace"
workspace=ros2_gui_ws

echo ""
echo "Set soft name"
soft_name=walking_rviz_plugins

echo ""
echo "Workspace if exits ?"
if [ ! -d ~/$workspace/src ];then 
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
cd ~/$workspace/src/
git clone -b ${ROS_DISTRO} https://gitee.com/ncnynl/walking_rviz_plugins

echo "Build the code"
cd ~/$workspace 
colcon build --symlink-install --packages-select ${soft_name}

if ! grep -Fq "$workspace/install/setup.bash" ~/.bashrc
then
    echo ". ~/$workspace/install/setup.bash" >> ~/.bashrc
    echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi

