#!/bin/bash
################################################
# Function : init_rmf.sh                              
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

if ! grep -Fq "load_free_fleet.sh" ~/.bashrc
then
    echo ". ~/commands/ros_easy/shell/load_free_fleet.sh" >> ~/.bashrc
    echo "Init Open-RMF Free Fleet workspace successfully! write to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi
