#!/bin/bash
################################################################
# Function : Update ROS2 Source                                 #
# Desc     : 用于更新ROS2源的脚本
# Platform :All Linux Basudo sed Platform                           #
# Version  :1.0                                                #
# Date     :2022-06-23                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Update ROS2 key")"

#set Key
sudo apt-get install curl 
curl -s https://ghproxy.com/https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -