#!/bin/bash
################################################################
# Function : Launch waking_app load_map                    
# Desc     : 启动医院场景
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
echo "$(gettext "Launch waking_app load_map")"

ros2 service call /map_server/load_map nav2_msgs/srv/LoadMap "{map_url: /home/ubuntu/aiwalking_ws/src/walking_application/maps/cafe_world/cafe_world.yaml}"