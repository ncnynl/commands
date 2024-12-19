#!/bin/bash
################################################################
# Function : Launch follower_aruco_goal                  
# Desc     : 启动follower_aruco_goal
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
echo "$(gettext "Launch follower_aruco_goal")"

ros2 run walking_follow follower_aruco_goal.py