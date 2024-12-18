#!/bin/bash
################################################################
# Function : Launch box_bot_1_odom                                   
# Desc     : 查看box_bot_1里程话题
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com/archives/202212/5782.html                                      
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch box_bot_1_odom")"

ros2 topic echo /box_bot_1/odom