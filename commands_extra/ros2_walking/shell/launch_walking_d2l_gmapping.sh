#!/bin/bash
################################################################
# Function : Launch walking_d2l_gmapping               
# Desc     : 启动walking_d2l_gmapping
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
echo "$(gettext "Launch walking_d2l_gmapping")"

export  LASER_TYPE="d2l"

ros2 launch walking_slam gmapping.launch.py