#!/bin/bash
################################################################
# Function : launch ignition_air_pressure                                  
# Desc     : 启动air_pressure
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com/archives/202201/4945.html                                     
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch ignition_air_pressure")"

ros2 launch ros_ign_gazebo_demos air_pressure.launch.py
