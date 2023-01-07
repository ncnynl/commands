#!/bin/bash
################################################
# Function : install_rpicamera_ros2.sh 
# Desc     : 用于源码方式安装ROS2版树莓派摄像头驱动的脚本                          
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-11-29                             
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
#        
echo "Not Yet Supported!"
exit 0    
workspace=ros2_sensor_ws

#workspace is exits ?
if [ ! -d ~/$workspace ];then 
    mkdir -p ~/$workspace/src
fi 

if [ -d ~/$workspace/src/rpicamera_ros2 ];then 
    echo "rpicamera_ros2 have installed" && exit 0
fi 


# 安装相应软件
sudo apt install ros-${ROS-DISTRO}-image-tools ros-${ROS-DISTRO}-usb-cam ros-${ROS-DISTRO}-compressed-image-transport

# 安装与编译软件包
cd ~/$workspace/src    
git clone https://github.com/EndlessLoops/rpicamera_ros2.git    


cd ~/$workspace/
colcon build --symlink-install  --packages-select rpicamera_ros2

# 启动摄像头
# ros2 launch rpicamera_ros2 rpicamera.launch.py

# 打开可视化界面，订阅话题/camera/image_raw/compressed
# ros2 run rqt_image_view rqt_image_view
