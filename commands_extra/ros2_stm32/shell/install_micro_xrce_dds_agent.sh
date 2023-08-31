#!/bin/bash
################################################
# Function : Install Micro-XRCE-DDS-Agent source 
# Desc     : 用于源码方式安装Micro-XRCE-DDS-Agent的脚本                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-08-31                           
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
echo "$(gettext "Install Micro-XRCE-DDS-Agent source")"

# echo "Tested ROS2 Version: galactic , humble"
# if installed ?
if [ -d ~/tools/Micro-XRCE-DDS-Agent ]; then
    echo "Micro-XRCE-DDS-Agent have installed!!" 
else 
    #install micro ros dds

    # 进入工作空间
    cd ~/tools

    # 获取仓库列表
    echo "this will take a while to download"

    # 下载仓库
    echo "Dowload micro_ros"
    if [  $ROS_DISTRO == "foxy" ]; then 
        git clone -b $ROS_DISTRO https://github.com/eProsima/Micro-XRCE-DDS-Agent
    else
        git clone https://github.com/eProsima/Micro-XRCE-DDS-Agent
    fi

    # 编辑各个包
    echo "build workspace..."
    cd Micro-XRCE-DDS-Agent

    mkdir build && cd build
    cmake ..
    make
    sudo make install

fi