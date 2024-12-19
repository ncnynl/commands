#!/bin/bash
################################################################
# Function : Launch walking_gazebo slam_toolbox                                
# Desc     : 启动walking_gazebo slam_toolbox  
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
echo "$(gettext "Launch walking_gazebo slam_toolbox")"

ros2 launch walking_slam slam_toolbox.launch.py use_sim_time:=true