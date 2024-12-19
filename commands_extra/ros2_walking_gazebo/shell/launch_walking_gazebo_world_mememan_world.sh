#!/bin/bash
################################################################
# Function : Launch walking_gazebo mememan_world                                
# Desc     : 启动mememan_world场景
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
echo "$(gettext "Launch walking_gazebo mememan_world")"

ros2 launch walking_gazebo world.launch.py world_model:=mememan_world.sdf