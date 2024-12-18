#!/bin/bash
################################################
# Function : Load turtlebot4 
# Desc     : 用于加载ROS1/ROS2 Turtlebot4工作空间的脚本                               
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-11-21                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Load turtlebot4")"

if [ -d ~/ros2_tb4_ws ]; then
    export CYCLONEDDS_URI='<CycloneDDS><Domain><General><DontRoute>true</></></></>'
    source ~/ros2_tb4_ws/install/local_setup.bash
fi