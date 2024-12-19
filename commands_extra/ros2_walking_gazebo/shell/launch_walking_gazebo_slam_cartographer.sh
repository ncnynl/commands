#!/bin/bash
################################################################
# Function : Launch walking_gazebo slam_gmapping                                
# Desc     : 启动walking_gazebo slam_gmapping  
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
echo "$(gettext "Launch walking_gazebo slam_gmapping")"

ros2 launch walking_slam gmapping.launch.py use_sim_time:=true