#!/bin/bash
################################################################
# Function : Launch waking_app run_inspection_v5                    
# Desc     : 启动房间检查v5
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
echo "$(gettext "Launch waking_app run_inspection_v5")"

ros2 run walking_application run_inspection_v5.py