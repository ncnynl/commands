#!/bin/bash
################################################################
# Function : Launch ignition rgbd_camera_bridge                           
# Desc     : 启动ignition rgbd_camera桥接
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com/archives/202201/4953.html                                 
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch ignition rgbd_camera_bridge")"

ros2 launch ros_ign_gazebo_demos rgbd_camera_bridge.launch.py
