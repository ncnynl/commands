#!/bin/bash
################################################################
# Function : Install ROS2 Galactic AMD/ARM version                     #
# Desc     : 用于AMD架构下安装ROS2 Galactic版本的脚本
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-06-23                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ROS2 Galactic AMD/ARM version")"

cpu=$(uname -m)
if [ $cpu == "x86_64" ]; then
    echo "Your cpu release is x86_64, please install AMD version "
    cs -si install_ros2_galactic_amd.sh
elif [ $cpu == "aarch64" ]; then
    echo "Your cpu release is x86_64, please install ARM version "
    cs -si install_ros2_galactic_arm.sh
fi