#!/bin/bash
################################################################
# Function : Launch rmf_barista_ff_3_freefleet                                  
# Desc     : 启动2台机器人freefleet
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
echo "$(gettext "Launch rmf_barista_ff_3_freefleet")"

ros2 launch barista_ros2_ff  freefleet_two_barista_turtleworld.launch.xml
