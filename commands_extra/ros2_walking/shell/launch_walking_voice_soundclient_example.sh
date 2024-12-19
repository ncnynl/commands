#!/bin/bash
################################################################
# Function : Launch walking soundclient_example                 
# Desc     : 启动walking soundclient_example
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
echo "$(gettext "Launch walking soundclient_example")"

ros2 launch walking_voice soundclient_example.launch.py