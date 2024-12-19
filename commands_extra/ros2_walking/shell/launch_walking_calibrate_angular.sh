#!/bin/bash
################################################################
# Function : Launch walking robot_calibrate_angular                 
# Desc     : 启动walking robot_calibrate_angular
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
echo "$(gettext "Launch walking robot_calibrate_angular")"

ros2 run walking_calib calibrate_angular.py