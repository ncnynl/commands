#!/bin/bash
################################################
# Function : install ros2 rmf source shell  
# Desc     : 用于APT方式安装ROS2 galactic版RMF框架的脚本                             
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
        

#安装gazebo源 
if [ ! -f /etc/apt/sources.list.d/gazebo-stable.list ];then
    sudo apt update
    sudo apt install -y wget
    sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
    wget https://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
fi 


#rmf
sudo apt install ros-galactic-rmf-demos-gz




