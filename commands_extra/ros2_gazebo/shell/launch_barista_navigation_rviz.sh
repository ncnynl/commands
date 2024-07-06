#!/bin/bash
################################################################
# Function : Launch barista_navigation_rviz                                   
# Desc     : 用于启动barista_navigation_rviz
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
echo "$(gettext "Launch barista_navigation_rviz")"

ros2 launch main_navigation start_navigation_rviz.launch.xml