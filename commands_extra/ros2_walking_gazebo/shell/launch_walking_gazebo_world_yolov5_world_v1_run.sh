#!/bin/bash
################################################################
# Function : Launch walking_gazebo yolov5                                
# Desc     : 启动yolov5
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
echo "$(gettext "Launch walking_gazebo yolov5")"

ros2 launch walking_yolov5 yolov5.launch.py image:=/depth_camera/image_raw