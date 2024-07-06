#!/bin/bash
################################################################
# Function : Launch turtlebot3_gazebo_empty_world                                   
# Desc     : 启动gazebo空地图
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
echo "$(gettext "Launch turtlebot3_gazebo_empty_world")"

ros2 launch turtlebot3_gazebo empty_world.launch.py
