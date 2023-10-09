#!/bin/bash
################################################
# Function : launch_gmapping 
# Desc     : 启动ailibot2建图算法gmapping的脚本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Mon Oct  9 10:19:19 AM CST 2023                            
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
echo "$(gettext "launch_gmapping")"

echo "This script is under DEV state !"

function rcm_execute() {
    ros2 launch ailibot2_slam gmapping.launch.py use_rviz:=true
}

# Execute current script
rcm_execute $*