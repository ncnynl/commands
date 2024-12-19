#!/bin/bash
################################################################
# Function : Launch turtlesim_mimic                                   
# Desc     : 启动跟随命令
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com/archives/202206/5287.html                                  
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch turtlesim_mimic")"

ros2 run turtlesim mimic --ros-args --remap input/pose:=turtle1/pose --remap output/cmd_vel:=turtle2/cmd_vel
