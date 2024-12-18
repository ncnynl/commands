#!/bin/bash
################################################################
# Function : Launch behavior_tree_photo_5_test_photo                               
# Desc     : 手动测试拍照
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com                                    
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch behavior_tree_photo_5_test_photo")"

ros2 service call /save "std_srvs/srv/Empty"