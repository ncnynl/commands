#!/bin/bash
################################################################
# Function : Launch rmf_office_mock_traffic_light_21.09                                  
# Desc     : 启动office_mock_traffic_light仿真21.09
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com/archives/202211/5674.html                                    
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch rmf_office_mock_traffic_light_21.09")"

ros2 launch rmf_demos_gz office_mock_traffic_light.launch.xml
