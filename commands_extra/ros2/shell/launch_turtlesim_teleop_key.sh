#!/bin/bash
################################################################
# Function : Launch ROS2 turtlesim teleop key                  
# Desc     : 用于启动ROS2版键盘控制的脚本
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2022-11-18                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://ncnynl.com                                      
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch ROS2 turtlesim teleop key")"

ros2 run turtlesim turtle_teleop_key