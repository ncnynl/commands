#!/bin/bash
################################################################
# Function : Launch follow_aruco_rviz                  
# Desc     : 启动follow_aruco_rviz
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
echo "$(gettext "Launch follow_aruco_rviz")"

ros2 launch walking_visual rviz_follow.launch.py