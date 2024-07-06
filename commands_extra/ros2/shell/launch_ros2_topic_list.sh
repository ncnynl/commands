#!/bin/bash
################################################################
# Function : Launch ros2 topic list                    
# Desc     : 查看ROS2话题列表
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2022-11-18                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://ncnynl.com                                      
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch ros2 topic list ")"

ros2 topic list