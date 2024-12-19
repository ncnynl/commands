#!/bin/bash
################################################################
# Function : Launch walking voice_arecord                 
# Desc     : 启动walking voice_arecord
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
echo "$(gettext "Launch walking voice_arecord")"

cd ~/tools/music/
arecord  -f cd test.wav