#!/bin/bash
################################################################
# Function : Launch box_bot_rviz                                   
# Desc     : 启动box_bot多机器人rviz
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
echo "$(gettext "Launch box_bot_rviz")"

ros2 launch box_bot_description start_rviz.launch.xml
