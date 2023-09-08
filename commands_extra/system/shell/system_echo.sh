#!/bin/bash
################################################
# Function : Check new fucntion shell  
# Desc     : 用于测试新开发的函数是否正常工作的脚本                           
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-06-28 19:14:02                            
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
echo "$(gettext "Check new function shell")"
#run echo 1

# source cs_utils
source ${HOME}/commands/cs_utils_ros.sh

# echo 1
# echo "$(gettext "Test First")"
# echo 1

# echo `check_ros_version galactic`
# echo `check_ros_version humble`
# echo `check_ros_version melodic`
# echo `check_ros_version noetic`
# echo `check_ros_version gala`
# echo `check_ros_version gala22ic`

