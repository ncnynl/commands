#!/bin/bash
################################################################
# Function : Launch rmf_hotel_21.09                                  
# Desc     : 启动hotel仿真21.09
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com/archives/202211/5669.html                                     
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch rmf_hotel_21.09")"

ros2 launch rmf_demos_gz hotel.launch.xml
