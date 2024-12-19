#!/bin/bash
################################################################
# Function : Launch tb4 ignition                                   
# Desc     : 启动tb4 ignition
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
echo "$(gettext "Launch tb4 ignition")"

ros2 launch turtlebot4_ignition_bringup ignition.launch.py