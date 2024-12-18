#!/bin/bash
################################################################
# Function : Launch turtlebot3_simulation                                   
# Desc     : 用于启动ROS1版本turtlebot3_simulation的脚本 
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
echo "$(gettext "Launch turtlebot3_simulation")"

roslaunch turtlebot3_gazebo turtlebot3_simulation.launch