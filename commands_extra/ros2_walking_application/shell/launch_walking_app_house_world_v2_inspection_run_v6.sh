#!/bin/bash
################################################################
# Function : Launch waking_app run_inspection_v6                    
# Desc     : 启动房间检查v6
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
echo "$(gettext "Launch waking_app run_inspection_v6")"

ros2 run walking_application run_inspection_v6.py