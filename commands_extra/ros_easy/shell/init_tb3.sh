#!/bin/bash
################################################
# Function : init_tb3.sh                              
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

if ! grep -Fq "load_tb3.sh" ~/.bashrc
then
    echo ". ~/commands/ros_easy/shell/load_tb3.sh" >> ~/.bashrc
    echo "Init turtlebot3 workspace successfully! write to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi

source ~/.bashrc 