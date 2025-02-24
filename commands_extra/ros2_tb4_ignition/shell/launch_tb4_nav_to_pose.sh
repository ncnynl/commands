#!/bin/bash
################################################################
# Function : Launch tb4 nav_to_pose                                  
# Desc     : 启动tb4 nav_to_pose
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
echo "$(gettext "Launch tb4 nav_to_pose")"

ros2 run turtlebot4_python_tutorials nav_to_pose