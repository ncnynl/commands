#!/bin/bash
################################################################
# Function : Launch nav2 bringup_v1                 
# Desc     : 启动nav2 bringup_v1 
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
echo "$(gettext "Launch nav2 bringup_v1")"

ros2 launch walking_navigation bringup_v1.launch.py use_slam:=true