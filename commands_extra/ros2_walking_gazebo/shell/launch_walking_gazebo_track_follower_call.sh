#!/bin/bash
################################################################
# Function : Launch walking_follow follower_call                              
# Desc     : 启动轨道跟随
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
echo "$(gettext "Launch walking_follow follower_call")"

ros2 service call /start_follower std_srvs/srv/Empty