#!/bin/bash
################################################################
# Function : Launch razor_imu_m0_driver                                   
# Desc     : 用于启动ROS1版本razor_imu_m0_driver的脚本 
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://ncnynl.com                                      
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch razor_imu_m0_driver")"

roslaunch razor_imu_m0_driver driver_node.launch