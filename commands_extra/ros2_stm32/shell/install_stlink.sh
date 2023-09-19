#!/bin/bash
################################################
# Function : Install stlink source 
# Desc     : 用于源码方式安装stlink的脚本                              
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
echo "$(gettext "Install stlink source")"

# if installed ?
if [ -d ~/tools/stlink ]; then
    echo "stlink have installed!!" 
else 
    #folder 
    if [ ! -d ~/tools ]; then 
        mkdir -p ~/tools/
    fi
        
    # install dep
    sudo apt-get update
    sudo apt-get install -y libusb-1.0
    sudo apt-get install -y pkg-config
    sudo apt-get install -y git
    sudo apt-get install -y cmake
    sudo apt-get install -y automake
    sudo apt-get install -y libgtk-3-dev
    sudo apt-get install -y openocd

    

    # 进入工作空间
    cd ~/tools

    # 获取仓库列表
    #replace https
    git config --global url."https://ghproxy.com/https://github.com".insteadof https://github.com
        
    #run import
    echo "this will take a while to download"

    # 下载仓库
    echo "Dowload stlink"
    git clone https://github.com/texane/stlink

    # 编辑各个包
    echo "build workspace..."
    cd stlink
    make release
    make debug
    cd build
    cmake -DCMAKE_BUILD_TYPE=Debug ..
    make
    cd release
    sudo make install

    #add rule
    cd ~/tools/stlink  
    sudo cp config/udev/rules.d/49-stlinkv2.rules /etc/udev/rules.d/
    sudo udevadm control --reload-rules
    sudo udevadm trigger

fi