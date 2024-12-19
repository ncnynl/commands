#!/bin/bash
################################################################
# Function : Launch waking_app hospital_world_connect_to_charging_dock_v3                    
# Desc     : 启动医院充电桩场景3
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
echo "$(gettext "Launch waking_app hospital_world_connect_to_charging_dock_v3")"

. /usr/share/gazebo/setup.bash 
ros2 launch walking_application hospital_world_connect_to_charging_dock_v3.launch.py