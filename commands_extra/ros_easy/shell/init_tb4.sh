#!/bin/bash
################################################
# Function : init_tb4.sh                              
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

if ! grep -Fq "load_tb4.sh" ~/.bashrc
then
    echo ". ~/commands/ros_easy/shell/load_tb4.sh" >> ~/.bashrc
    echo "Init turtlebot4 workspace successfully! write to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi
source ~/.bashrc