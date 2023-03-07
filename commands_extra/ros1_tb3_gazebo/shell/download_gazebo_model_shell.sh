#!/bin/bash
################################################
# Function : Download gazebo model shell 
# Desc     : 用于下载Gazebo所有模型的脚本                             
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-07-02 01:45:01                            
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
echo "$(gettext "Download gazebo model shell")"

#model same as ros2
pwd=$(pwd)
sh -c "$pwd/../ros2_tb3_gazebo/shell/download_gazebo_model_shell.sh"