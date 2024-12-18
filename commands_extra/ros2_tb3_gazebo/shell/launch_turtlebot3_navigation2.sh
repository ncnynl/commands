#!/bin/bash
################################################################
# Function : Launch turtlebot3_navigation2                                   
# Desc     : 启动turtlebot3导航
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
echo "$(gettext "Launch turtlebot3_navigation2")"

ros2 launch turtlebot3_navigation2 navigation2.launch.py use_sim_time:=True map:=/home/ubuntu/map.yaml
