#!/bin/bash
################################################################
# Function : Launch turtlebot4_navigation_with_slam_sync                                   
# Desc     : 启动异步建图的导航模式
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
echo "$(gettext "Launch turtlebot4_navigation_with_slam_sync")"

ros2 launch turtlebot4_navigation nav_bringup.launch.py slam:=sync
