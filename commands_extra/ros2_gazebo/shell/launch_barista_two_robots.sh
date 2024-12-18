#!/bin/bash
################################################################
# Function : Launch barista_two_robots                                   
# Desc     : 启动baristad2个机器人的仿真
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
echo "$(gettext "Launch barista_two_robots")"

ros2 launch barista_gazebo main_two_robots_turtleworld.launch.xml
