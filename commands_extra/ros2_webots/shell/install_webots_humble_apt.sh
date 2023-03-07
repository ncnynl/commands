#!/bin/bash
################################################
# Function : Install ROS2 humble webots  apt version   
# Desc     : 用于APT方式安装ROS2 humble版仿真软件webots的脚本                            
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-07-02 02:39:30                            
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
echo "$(gettext "Install ROS2 humble webots  apt version")"    

# 添加webots源

# wget -qO- https://cyberbotics.com/Cyberbotics.asc | sudo apt-key add -
# sudo apt-add-repository 'deb https://cyberbotics.com/debian/ binary-amd64/'

#更新
sudo apt update

#安装
# sudo apt-get install webots
sudo apt install ros-humble-webots-ros2-driver
