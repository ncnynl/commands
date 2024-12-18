#!/bin/bash
################################################################
# Function : Launch ublox_gps                               
# Desc     : 用于启动ROS1版本ublox_gps驱动的脚本 
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
echo "$(gettext "LLaunch ublox_gps ")"

roslaunch ublox_gps ublox_gps.launch