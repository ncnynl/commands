#!/bin/bash
################################################################
# Function : Launch TakePanorama                  
# Desc     : 启动TakePanorama
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
echo "$(gettext "Launch TakePanorama")"

ros2 service call /take_pano walking_msgs/TakePanorama "{mode: 0 , pano_angle: 360.0 , snap_interval: 10.0 , rot_vel: 0.1}"