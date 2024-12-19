#!/bin/bash
################################################################
# Function : Launch waking_app charging_battery_pub                    
# Desc     : 发布正在充电状态
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
echo "$(gettext "Launch waking_app charging_battery_pub")"

ros2 run walking_application charging_battery_pub.py