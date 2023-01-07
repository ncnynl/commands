#!/bin/bash
################################################
# Function : load_free_fleet.sh  
# Desc     : 用于加载free_fleet的脚本                            
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

if [ -d ~/ros2_free_fleet_ws ]; then
    source ~/ros2_free_fleet_ws/install/local_setup.bash
fi