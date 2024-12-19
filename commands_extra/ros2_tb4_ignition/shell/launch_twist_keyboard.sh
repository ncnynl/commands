#!/bin/bash
################################################################
# Function : Launch teleop_twist_keyboard                                 
# Desc     : 启动键盘
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
echo "$(gettext "Launch teleop_twist_keyboard")"

ros2 run teleop_twist_keyboard teleop_twist_keyboard