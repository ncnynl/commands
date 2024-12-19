#!/bin/bash
################################################################
# Function : Launch walking voice_text2wave                 
# Desc     : 启动walking voice_text2wave
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
echo "$(gettext "Launch walking voice_text2wave")"

cd ~/tools/music/
echo "It's such a beautiful day! Why are you in front of the computer?" | text2wave  -o beautiful_day.wav