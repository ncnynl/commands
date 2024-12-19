#!/bin/bash
################################################################
# Function : Launch walking_bt bt_ros2                                
# Desc     : 启动行为树.实现导航三个指定的坐标点.
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
echo "$(gettext "Launch walking_bt bt_ros2")"

ros2 launch walking_bt bt_ros2.launch.py