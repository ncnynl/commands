#!/bin/bash
################################################
# Function : Install ROS2 Micro ROS DDS source 
# Desc     : 用于源码方式安装ROS2版本Micro ROS DDS的脚本                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-08-26                         
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
echo "$(gettext "Install ROS2 ${ROS_DISTRO}  Micro ROS DDS source")"

# echo "Tested ROS2 Version: galactic , humble"
# if installed ?
echo "This packages included Micro-XRCE-DDS-Client, Micro-XRCE-DDS-Agent, Micro-XRCE-DDS-Gen "
if [ -d ~/tools/Micro-XRCE-DDS ]; then
    echo "Micro ROS DDS have installed!! But please check if this is a newest version."
    echo "If You want to reinstall, Please delete ~/tools/Micro-XRCE-DDS  try again" 
else 
    #folder 
    if [ ! -d ~/tools ]; then 
        mkdir -p ~/tools/
    fi

    # install dep

    # 进入工作空间
    cd ~/tools

    # 获取仓库列表
    #run import
    echo "this will take a while to download"

    #replace https
    git config --global url."https://ghproxy.com/https://github.com".insteadof https://github.com

    # 下载仓库
    echo "Dowload Micro-XRCE-DDS"
    git clone https://github.com/eProsima/Micro-XRCE-DDS.git

    # 编辑各个包
    echo "build workspace..."
    cd ~/tools/Micro-XRCE-DDS
    mkdir build && cd build
    cmake ..    
    
    cd ~/tools/Micro-XRCE-DDS/build  
    make  
    sudo make install
    sudo ldconfig /usr/local/lib/
fi