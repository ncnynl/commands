#!/bin/bash
################################################################
# Function : Launch barista_1_2_mule_nav                                   
# Desc     : 同时启动1/2/mule机器人导航
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
echo "$(gettext "Launch barista_1_2_mule_nav")"

ros2 launch main_navigation start_nav_barista_1_2_mule_turtleworld.launch.xml

