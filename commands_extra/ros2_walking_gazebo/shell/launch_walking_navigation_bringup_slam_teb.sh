#!/bin/bash
################################################################
# Function : Launch walking_navigation bringup_slam_teb                              
# Desc     : 启动导航,采用建图方式
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
echo "$(gettext "Launch walking_navigation bringup_slam_teb")"

ros2 launch walking_navigation teb.launch.py use_slam:=true use_sim_time:=true