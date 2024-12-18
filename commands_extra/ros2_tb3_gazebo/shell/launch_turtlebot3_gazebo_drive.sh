#!/bin/bash
################################################################
# Function : Launch turtlebot3_gazebo_drive                                   
# Desc     : 执行自走避障仿真程序
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
echo "$(gettext "Launch turtlebot3_gazebo_drive")"

ros2 run turtlebot3_gazebo turtlebot3_drive
