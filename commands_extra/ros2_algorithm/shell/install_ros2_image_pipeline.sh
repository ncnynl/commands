#!/bin/bash
################################################
# Function : Install ROS2 image_pipeline source version
# Desc     : 用于源码方式安装ROS2版image_pipeline的脚本                       
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-03-27                         
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
echo "$(gettext "Install ROS2 image_pipeline source version")"

# echo "Not Supported Yet!"
# exit 0  
echo ""
echo "Set workspace"
workspace=ros2_algorithm_ws

echo ""
echo "Set soft name"
soft_name=image_pipeline

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
sudo apt update


# 下载源码
echo ""
echo "Download source"
cd ~/$workspace/src

branch="${ROS_DISTRO}"

echo "Choose branch is ${branch}"
git clone -b ${branch} https://github.com/ros-perception/image_pipeline
# git clone -b ${branch} https://ghproxy.com/https://github.com/ros-perception/image_pipeline

echo ""
echo "Install rosdeps"
cs -si update_rosdep_tsinghua
cd ~/$workspace/
rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y

# 编译代码
echo "Compile source"
cd ~/$workspace/
colcon build --symlink-install 


# echo "Add workspace to bashrc if not exits"
# if ! grep -Fq "$workspace/install/local_setup.bash" ~/.bashrc
# then
#     echo ". ~/$workspace/install/local_setup.bash" >> ~/.bashrc
#     echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
# else
#     echo "Has been inited before! Please check ~/.bashrc"
# fi

cs -ss load_ros2_algorithm_ws -add

#How to use
