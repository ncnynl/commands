#!/bin/bash
################################################################
# Function : Launch ignition IMU                           
# Desc     : 启动ignition IMU 
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com/archives/202201/4951.html                                   
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch ignition IMU")"

ros2 launch ros_ign_gazebo_demos imu.launch.py
