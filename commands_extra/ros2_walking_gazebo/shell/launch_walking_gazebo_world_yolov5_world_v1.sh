#!/bin/bash
################################################################
# Function : Launch walking_gazebo yolov5_world_v1                                
# Desc     : 启动yolov5_world_v1场景
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com                                    
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch walking_gazebo yolov5_world_v1")"

ros2 launch walking_gazebo yolov5_world_v1.launch.py