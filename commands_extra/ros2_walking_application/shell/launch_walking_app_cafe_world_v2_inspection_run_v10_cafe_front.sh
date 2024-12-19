#!/bin/bash
################################################################
# Function : Launch waking_app run_inspection_v10_cafe_front                    
# Desc     : 启动咖啡店派送v10
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
echo "$(gettext "Launch waking_app run_inspection_v10_cafe_front")"

cd ~/tools/pyqt/cafe/
python3 cafe_front.py