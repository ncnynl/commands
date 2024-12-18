#!/bin/bash
################################################################
# Function : Launch turtlebot3_navigation                                   
# Desc     : 用于启动ROS1版本turtlebot3_navigation的脚本 
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
echo "$(gettext "Launch turtlebot3_navigation")"

export TURTLEBOT3_MODEL=burger;roslaunch turtlebot3_navigation turtlebot3_navigation.launch map_file:=$HOME/map.yaml