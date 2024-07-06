#!/bin/bash
################################################################
# Function : Launch rmf-panel-js                                   
# Desc     : 启动panel面板
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com/archives/202211/5670.html                                     
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch rmf-panel-js")"

cd ~/ros2_rmf_ws/rmf-panel-js/; ./load_http.sh
