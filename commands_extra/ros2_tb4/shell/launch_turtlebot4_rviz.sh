#!/bin/bash
################################################################
# Function : Launch turtlebot4_rviz                                   
# Desc     : 启动turtlebot4_rviz
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com/archives/202206/5287.html                                  
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch turtlebot4_rviz")"

ros2 launch turtlebot4_viz view_robot.launch.py
