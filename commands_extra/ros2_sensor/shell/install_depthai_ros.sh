#!/bin/bash
################################################
# Function : Install ROS2 depthai-ros 
# Desc     : 用于源码方式安装ROS2版depthai-ros驱动的脚本                         
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
# https://github.com/luxonis/depthai-ros.git


export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ROS2 depthai-ros")"

# echo "Not Yet Supported!"
# exit 0   
# workspace       
workspace=ros2_sensor_ws

#workspace is exits ?
if [ ! -d ~/$workspace ];then 
    mkdir -p ~/$workspace/src
fi 

if [ -d ~/$workspace/src/depthai-ros ];then 
    echo "depthai-ros have installed" && exit 0
fi 

#install rosdeps


# 下载源码
cs -si update_rosdep_tsinghua

cd ~/$workspace/src

#download wheeltec_gps
git clone -b ${ROS_DISTRO}  https://github.com/luxonis/depthai-ros.git

cd ~/$workspace/
rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y

# 编译代码
colcon build --symlink-install --parallel-workers 1 --packages-select depthai-ros depthai_bridge depthai_descriptions depthai_examples  depthai_filters depthai_ros_driver  depthai_ros_msgs 

#udev 

echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="03e7", MODE="0666"' | sudo tee /etc/udev/rules.d/80-movidius.rules
sudo udevadm control --reload-rules && sudo udevadm trigger

#add to bashrc if not exits
if ! grep -Fq "$workspace/install/local_setup.bash" ~/.bashrc
then
    echo ". ~/$workspace/install/local_setup.bash" >> ~/.bashrc
    echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi