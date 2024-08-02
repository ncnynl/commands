#!/bin/bash
################################################################
# Function : Update ROS1 Key                                 
# Desc     : 用于更新ROS1源的密钥的脚本
# Platform :All Linux Basudo sed Platform                           
# Version  :1.0                                                
# Date     :2023-06-08                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://ncnynl.com                                      
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Update ROS1 key")"

#set Key
sudo apt-get install curl 
# curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
# sudo sh -c 'echo "deb http://mirrors.aliyun.com/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt update