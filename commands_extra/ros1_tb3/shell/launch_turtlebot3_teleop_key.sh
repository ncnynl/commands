#!/bin/bash
################################################################
# Function : Launch turtlebot3_teleop_key                                   
# Desc     : 用于启动ROS1版本turtlebot3_teleop_key的脚本 
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://ncnynl.com                                      
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch turtlebot3_teleop_key")"

roslaunch turtlebot3_teleop turtlebot3_teleop_key.launch