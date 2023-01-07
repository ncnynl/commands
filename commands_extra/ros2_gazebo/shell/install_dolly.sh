#!/bin/bash
################################################
# Function : install_dolly   
# Desc     : 用于源码方式安装ROS2版dolly仿真的脚本                      
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-12-09                          
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################


case $ROS_DISTRO in
'foxy'|'galactic')
    echo "install $ROS_DISTRO version for dolly"
    ;; 
*)
    echo "$ROS_DISTRO version is not supported yet!"
    exit 0 
    ;; 
esac 

echo ""
echo "Set workspace"
workspace=ros2_gazebo_ws

echo ""
echo "Set soft name"
soft_name=dolly

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
git clone -b $ROS_DISTRO https://ghproxy.com/https://github.com/chapulina/dolly

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
