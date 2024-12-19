#!/bin/bash
################################################################
# Function : Launch walking rosbag_record_offline_mapping                 
# Desc     : 启动walking rosbag_record_offline_mapping
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
echo "$(gettext "Launch walking rosbag_record_offline_mapping")"

cd ~/bag_files
ros2 bag record -o offline_mapping -a