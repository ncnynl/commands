#!/bin/bash
################################################
# Function : Install rmf burger maps  
# Desc     : 用于源码方式安装ROS2 humble版自定义Burger地图RMF导航包的脚本
# Website  : https://www.ncnynl.com/archives/202212/5781.html                       
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-12-08                          
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
echo "$(gettext "Install rmf burger maps")" 

echo ""
echo "Set workspace"
workspace=ros2_rmf_map_ws

echo ""
echo "Set soft name"
soft_name=rmf_burger_maps

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
git clone -b master https://gitee.com/ncnynl/rmf_burger_maps

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
