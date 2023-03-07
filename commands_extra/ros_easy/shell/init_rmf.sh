#!/bin/bash
################################################
# Function : Init rmf
# Desc     : 用于初始化RMF多智能体框架环境的脚本                              
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
echo "$(gettext "Init rmf")"

if ! grep -Fq "load_rmf.sh" ~/.bashrc
then
    echo ". ~/commands/ros_easy/shell/load_rmf.sh" >> ~/.bashrc
    echo "Init Open-RMF workspace successfully! write to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi
