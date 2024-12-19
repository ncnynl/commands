#!/bin/bash
################################################################
# Function : Launch walking test_keyboard_simple                
# Desc     : 启动walking test_keyboard_simple
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-08                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://ncnynl.com                                      
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch walking test_keyboard_simple")"

ros2 launch walking_teleop keyboard_simple.launch.py