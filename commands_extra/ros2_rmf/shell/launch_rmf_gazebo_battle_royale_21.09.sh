#!/bin/bash
################################################################
# Function : Launch battle_royale_21.09                                  
# Desc     : 启动battle_royale仿真21.09
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com/archives/202211/5673.html                                     
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch battle_royale_21.09")"

ros2 launch rmf_demos_gz battle_royale.launch.xml
