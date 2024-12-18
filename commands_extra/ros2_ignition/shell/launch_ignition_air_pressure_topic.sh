#!/bin/bash
################################################################
# Function : Launch ignition air_pressure topic                                
# Desc     : 查看air_pressure数据
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com/archives/202201/4945.html                                     
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch ignition air_pressure topic")"

ros2 topic echo /air_pressure --qos-reliability best_effort
