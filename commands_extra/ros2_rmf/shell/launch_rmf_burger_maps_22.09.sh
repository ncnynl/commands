#!/bin/bash
################################################################
# Function : Launch rmf_burger_maps_22.09                                  
# Desc     : 启动rmf_burger_maps仿真22.09
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com/archives/202211/5668.html                                     
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch rmf_burger_maps_22.09")"

ros2 launch rmf_burger_maps burger.launch.xml server_uri:="ws://localhost:7878"

#launch_rmf_panel_js.sh