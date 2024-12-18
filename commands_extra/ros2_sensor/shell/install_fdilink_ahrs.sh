#!/bin/bash
################################################
# Function : Install ROS2 fdilink_ahrs 
# Desc     : 用于源码方式安装ROS2版fdilink_ahrs驱动的脚本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2024-12-09                          
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
# https://github.com/jinmenglei/serial_ros2
# https://gitee.com/ncnynl/fdilink_ahrs_ros2


export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ROS2 fdilink_ahrs")"

# echo "Not Yet Supported!"
# exit 0   
# workspace       
workspace=ros2_sensor_ws

#workspace is exits ?
if [ ! -d ~/$workspace ];then 
    mkdir -p ~/$workspace/src
fi 

if [ -d ~/$workspace/src/fdilink_ahrs ];then 
    echo "fdilink_ahrs have installed" && exit 0
fi 

#install rosdeps


# 下载源码
cs -si update_rosdep_tsinghua

cd ~/$workspace/src

#download serial_ros2
git clone https://github.com/jinmenglei/serial_ros2
#download fdilink_ahrs_ros2
git clone https://gitee.com/ncnynl/fdilink_ahrs_ros2

cd ~/$workspace/
rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y

# 编译代码
colcon build --symlink-install --packages-select serial fdilink_ahrs

#udev
echo 'KERNEL=="ttyUSB*", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60", MODE:="0777", SYMLINK+="fdilink_ahrs"' | sudo tee /etc/udev/rules.d/fdilink_ahrs.rules

service udev reload
sleep 2
service udev restart

#add to bashrc if not exits
if ! grep -Fq "$workspace/install/local_setup.bash" ~/.bashrc
then
    echo ". ~/$workspace/install/local_setup.bash" >> ~/.bashrc
    echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi


# 启动雷达
# ros2 launch fdilink_ahrs ahrs_driver.launch.py

# 查看激光数据
# rviz2 



