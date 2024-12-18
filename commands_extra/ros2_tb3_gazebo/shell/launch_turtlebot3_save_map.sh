#!/bin/bash
################################################################
# Function : Launch turtlebot3_save_map                                   
# Desc     : 启动turtlebot3保存地图
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
echo "$(gettext "Launch turtlebot3_save_map")"

ros2 run nav2_map_server map_saver_cli -f ~/map
