#!/bin/bash
################################################################
# Function : Launch walking rtabmap_rgbd                
# Desc     : 启动walking rtabmap_rgbd
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-08                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://ncnynl.com                                      
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch walking rtabmap_rgbd")"

ros2 launch walking_navigation bringup_v2.launch.py  slam_type:=rtabmap_rgbd