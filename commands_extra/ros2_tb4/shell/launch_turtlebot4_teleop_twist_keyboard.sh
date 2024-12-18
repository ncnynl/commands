#!/bin/bash
################################################################
# Function : Launch turtlebot4_teleop_twist_keyboard                                  
# Desc     : 运行turtlebot4键盘控制
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com/archives/202206/5286.html                                 
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch turtlebot4_teleop_twist_keyboard")"

ros2 run teleop_twist_keyboard teleop_twist_keyboard
