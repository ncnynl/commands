#!/bin/bash
################################################
# Function : Install rmf traffic editor apt version
# Desc     : 用于APT方式安装RMF地图编辑器traffic editor的脚本                             
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-07-06 18:22:04                            
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
echo "$(gettext "Install rmf traffic editor apt version")"

# https://github.com/open-rmf/rmf_traffic_editor
#基于ubuntu22.04
#安装依赖 

echo "Install rmf_traffic_editor"
sudo apt install -y ros-${ROS_DISTRO}-rmf-traffic-editor

