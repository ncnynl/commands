#!/bin/bash
################################################
# Function : Install Rplidar ROS 
# Desc     : 用于源码方式安装ROS1版本rplidar驱动的脚本                      
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2024-08-17                          
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
echo "$(gettext "Install Rplidar ROS")"

# echo "Not Supported Yet!"
# exit 0  
echo ""
echo "Set workspace"
workspace=ros1_sensor_ws

echo ""
echo "Set soft name"
soft_name=rplidar_ros

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
git clone https://github.com/Slamtec/rplidar_ros

if [ ! -d ~/$workspace/src/$soft_name ];then 
echo " Download failed! " && exit 0
fi

echo ""
echo "Install rosdeps"
cs -si update_rosdep_tsinghua
cd ~/$workspace/
rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y


# 编译代码
echo "Compile source"
cd ~/$workspace/
catkin_make --pkg  rplidar_ros

echo "Add workspace to bashrc if not exits"
if ! grep -Fq "$workspace/devel/setup.bash" ~/.bashrc
then
    echo ". ~/$workspace/devel/setup.bash" >> ~/.bashrc
    echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi

#How to use
