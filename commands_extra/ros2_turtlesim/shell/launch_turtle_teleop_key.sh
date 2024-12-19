#!/bin/bash
################################################################
# Function : Launch turtle_teleop_key                                   
# Desc     : 启动turtle1键盘控制
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com/archives/202206/5287.html                                  
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch turtle_teleop_key")"

ros2 run turtlesim turtle_teleop_key
