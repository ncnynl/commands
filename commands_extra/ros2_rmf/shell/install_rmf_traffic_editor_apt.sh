#!/bin/bash
################################################
# Function : install rmf traffic editor apt                              
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
# https://github.com/open-rmf/rmf_traffic_editor
#基于ubuntu22.04
#安装依赖 

echo "Install rmf_traffic_editor"
sudo apt install -y ros-${ROS_DISTRO}-rmf-traffic-editor

