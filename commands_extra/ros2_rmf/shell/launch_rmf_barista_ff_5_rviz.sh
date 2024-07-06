#!/bin/bash
################################################################
# Function : Launch rmf_barista_ff_5_rviz                                  
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
echo "$(gettext "Launch rmf_barista_ff_5_rviz")"

ros2 launch main_navigation start_navigation_rviz.launch.xml
