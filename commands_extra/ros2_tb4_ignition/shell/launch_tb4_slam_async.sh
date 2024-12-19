#!/bin/bash
################################################################
# Function : Launch tb4 async slam                                  
# Desc     : 同步SLAM
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
echo "$(gettext "Launch tb4 async slam")"

ros2 launch turtlebot4_ignition_bringup ignition.launch.py slam:=async nav2:=true rviz:=true