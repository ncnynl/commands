#!/bin/bash
################################################
# Function : Init ROS1
# Desc     : 用于初始化ROS1环境的脚本                               
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
echo "$(gettext "Init ROS1")"

if ! grep -Fq "load_ros1.sh" ~/.bashrc
then
    echo ". ~/commands/ros_easy/shell/load_ros1.sh" >> ~/.bashrc
    echo "Init ros1 successfully! writed to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi

source ~/.bashrc