#!/bin/bash
################################################
# Function : Install ROS2 navigation2 source version
# Desc     : 用于源码方式安装ROS2版Navigation2的脚本                       
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-12-10                          
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
echo "$(gettext "Install ROS2 navigation2 source version")"

# echo "Not Supported Yet!"
# exit 0  
echo ""
echo "Set workspace"
workspace=ros2_navigation_ws

echo ""
echo "Set soft name"
soft_name=navigation2

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

case ${ROS_DISTRO} in
'foxy'|'eloquent'|'dashing'|'crystal')
    branch="${ROS_DISTRO}-devel" 
    ;;
*)
    branch="${ROS_DISTRO}"
    ;;
esac 
echo "Choose branch is ${branch}"
git clone -b ${branch} https://ghproxy.com/https://github.com/ros-planning/navigation2.git

echo ""
echo "Install rosdeps"
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
