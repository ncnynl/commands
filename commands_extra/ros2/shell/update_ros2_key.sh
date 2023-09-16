#!/bin/bash
################################################################
# Function : Update ROS2 Key                                 
# Desc     : 用于更新ROS2源密钥的脚本
# Platform :All Linux Basudo sed Platform                           
# Version  :1.0                                                
# Date     :2022-06-23                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://ncnynl.com                                      
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Update ROS2 key")"

#set Key
sudo apt-get install curl 
#sudo curl http://repo.ros2.org/repos.key | sudo apt-key add -
sudo curl -sSL https://ghproxy.com/https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
sudo apt update