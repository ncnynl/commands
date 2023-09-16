#!/bin/bash
################################################################
# Function : Launch turtlesim                                   
# Desc     : 用于启动ROS1版本turtlesim的脚本 
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
echo "$(gettext "Launch turtlesim")"

rosrun turtlesim turtlesim_node