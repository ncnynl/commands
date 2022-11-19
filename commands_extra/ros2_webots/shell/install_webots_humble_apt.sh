#!/bin/bash
################################################
# Function : install_webots_galactic_apt.sh                              
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
        

# 添加webots源

# wget -qO- https://cyberbotics.com/Cyberbotics.asc | sudo apt-key add -
# sudo apt-add-repository 'deb https://cyberbotics.com/debian/ binary-amd64/'

#更新
sudo apt update

#安装
# sudo apt-get install webots
sudo apt install ros-humble-webots-ros2-driver
