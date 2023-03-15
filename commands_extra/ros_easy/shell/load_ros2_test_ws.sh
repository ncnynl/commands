#!/bin/bash
################################################
# Function : Load ros2_test_ws workspace 
# Desc     : 用于加载ros2_test_ws工作空间的脚本                                 
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-03-15                           
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
echo "$(gettext "Load ros2_test_ws workspace")"
workspace="ros2_test_ws"
if [ -d ~/$workspace ]; then
    source ~/$workspace/install/local_setup.bash
fi