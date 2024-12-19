#!/bin/bash
################################################################
# Function : Launch walking_slam_cartographer                 
# Desc     : 启动walking walking_slam_cartographer
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
echo "$(gettext "Launch walking walking_slam_cartographer")"

ros2 launch walking_slam cartographer.launch.py