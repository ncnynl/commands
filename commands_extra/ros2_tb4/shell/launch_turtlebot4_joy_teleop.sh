#!/bin/bash
################################################################
# Function : Launch turtlebot4_joy_teleop                                  
# Desc     : 运行turtlebot4手柄控制
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com/archives/202206/5283.html                                
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch turtlebot4_joy_teleop")"

ros2 launch turtlebot4_bringup joy_teleop.launch.py
