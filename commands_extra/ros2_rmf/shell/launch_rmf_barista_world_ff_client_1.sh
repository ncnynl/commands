#!/bin/bash
################################################################
# Function : Launch rmf_barista_world_ff_client_1                           
# Desc     : 启动ff client1，launch_rmf_barista_ff_1_robots分步
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
echo "$(gettext "Launch rmf_barista_world_ff_client_1")"

ros2 launch barista_ros2_ff  start_ff_client_barista.launch.xml barista_name:=barista_1