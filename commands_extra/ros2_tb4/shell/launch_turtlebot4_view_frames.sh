#!/bin/bash
################################################################
# Function : Launch turtlebot4_view_frames                                  
# Desc     : 运行turtlebot4查看TF树
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
echo "$(gettext "Launch turtlebot4_view_frames")"

ros2 run tf2_tools view_frames

#evince frames.pdf