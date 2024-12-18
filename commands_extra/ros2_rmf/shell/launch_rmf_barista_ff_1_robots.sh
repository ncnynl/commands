#!/bin/bash
################################################################
# Function : Launch rmf_barista_ff_1_robots                                  
# Desc     : 启动barista_gazebo仿真2台机器人
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com/archives/202211/5668.html                                     
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch rmf_barista_ff_1_robots")"

ros2 launch barista_gazebo main_two_robots_turtleworld.launch.xml
