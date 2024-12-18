#!/bin/bash
################################################
# Function : Install bcr_bot source     
# Desc     : 用于源码方式安装ROS2版bcr-bot的脚本
# Website  : https://www.ncnynl.com
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
#https://github.com/blackcoffeerobotics/bcr_bot
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install bcr_bot source ")"

echo ""
echo "Set workspace"
workspace=ros2_bcrbot_ws

echo ""
echo "Set soft name"
soft_name=bcr_bot

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
git clone -b ros2 https://github.com/blackcoffeerobotics/bcr_bot


echo "Download models"
git clone -b ros2 https://github.com/aws-robotics/aws-robomaker-small-warehouse-world

echo ""
echo "Install rosdeps"
cs -si update_rosdep_tsinghua
cd ~/$workspace/
rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y


# 编译代码
echo "Compile source"
cd ~/$workspace/
colcon build --symlink-install 


#copy model to ignition models
if [ -d ~/.ignition/fuel/fuel.ignitionrobotics.org/models ];then 

    cp -r  ~/$workspace/src/aws-robomaker-small-warehouse-world/models/* ~/.ignition/fuel/fuel.ignitionrobotics.org/models

else

    cp -r  ~/$workspace/src/aws-robomaker-small-warehouse-world/models ~/.ignition/fuel/fuel.ignitionrobotics.org/

fi


echo "Add workspace to bashrc if not exits"
if ! grep -Fq "$workspace/install/local_setup.bash" ~/.bashrc
then
    echo ". ~/$workspace/install/local_setup.bash" >> ~/.bashrc
    echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi

#How to use
