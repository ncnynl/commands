#!/bin/bash
################################################################
# Function : Launch panorama                  
# Desc     : 启动panorama
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
echo "$(gettext "Launch panorama")"

ros2 run walking_panorama panorama --ros-args  --remap /camera/image:=/camera/color/image_raw