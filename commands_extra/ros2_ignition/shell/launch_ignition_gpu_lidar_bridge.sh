#!/bin/bash
################################################################
# Function : Launch ignition gpu_lidar_bridge                           
# Desc     : 启动ignition GPU雷达桥接
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com/archives/202201/4950.html                                   
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch ignition gpu_lidar_bridge")"

ros2 launch ros_ign_gazebo_demos gpu_lidar_bridge.launch.py
