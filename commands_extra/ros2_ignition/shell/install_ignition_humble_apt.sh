#!/bin/bash
################################################
# Function : Install ignition humble apt version     
# Desc     : 用于APT方式安装ROS2 humble版仿真软件ignition的脚本                          
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-11-19                            
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
echo "$(gettext "Install ignition humble apt version")" 

#run 

sudo apt install ros-humble-ros-ign -y



