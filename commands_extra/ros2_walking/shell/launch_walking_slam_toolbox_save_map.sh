#!/bin/bash
################################################################
# Function : Launch walking_slam_toolbox_save_map               
# Desc     : 启动walking_slam_toolbox_save_map
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
echo "$(gettext "Launch walking slam_toolbox_save_map")"

ros2 launch walking_slam save_map.launch.py  map:=${HOME}/map/slam_toolbox