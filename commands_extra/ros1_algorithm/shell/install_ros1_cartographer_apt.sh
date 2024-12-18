#!/bin/bash
################################################
# Function : Install cartographer apt version
# Desc     : 用于APT方式安装ROS1版本激光建图算法cartographer的脚本                         
# Platform : ubuntu                                
# Version  : 1.0                              
# Date     : 2022-11-29                          
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
echo "$(gettext "Install cartographer apt version")"

#        
# echo "Not Yet Supported!"
# exit 0    

sudo apt install ros-${ROS_DISTRO}-cartographer
sudo apt install ros-${ROS_DISTRO}-cartographer-ros

