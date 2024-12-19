#!/bin/bash
################################################################
# Function : Launch walking rosbag_laser                 
# Desc     : 启动walking rosbag_laser
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-08                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://ncnynl.com                                      
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch walking rosbag_laser")"

ros2 launch walking_tools rosbag_laser.launch.py 