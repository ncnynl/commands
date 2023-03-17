#!/bin/bash
################################################################
# Function :Install ROS2 Humble AMD/ARM version                    #
# Desc     : 用于安装ROS2 Humble版本的脚本
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-07-08                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ROS2 Humble AMD/ARM version")"

cpu=$(uname -m)
if [ $cpu == "x86_64" ]; then
    echo "Your cpu release is x86_64, please install AMD version "
    cs -si install_ros2_humble_amd.sh
elif [ $cpu == "aarch64" ]; then
    echo "Your cpu release is x86_64, please install ARM version "
    cs -si install_ros2_humble_arm.sh
fi