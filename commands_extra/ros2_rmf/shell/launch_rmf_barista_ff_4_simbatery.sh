#!/bin/bash
################################################################
# Function : Launch rmf_barista_ff_4_simbatery                                  
# Desc     : 启动电池仿真
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com/archives/202211/5668.html                                     
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch rmf_barista_ff_4_simbatery")"

ros2 launch barista_ros2_ff  simbatery_two_barista_turtleworld.launch.xml
