#!/bin/bash
################################################################
# Function : Launch walking_gazebo slam_gmapping_save_map                                
# Desc     : 启动walking_gazebo slam_gmapping_save_map  
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
echo "$(gettext "Launch walking_gazebo slam_gmapping_save_map")"

ros2 run nav2_map_server map_saver_cli -f ~/map/map --ros-args -p save_map_timeout:=10000.00