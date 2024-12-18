#!/bin/bash
################################################
# Function : Install joy       
# Desc     : 用于安装joy的脚本                       
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2024-08-02                         
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
# Website: https://www.ncnynl.com/archives/201904/2952.html
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install joy")"

sudo apt update 

sudo apt install ros-$ROS_DISTRO-joy









