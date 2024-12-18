#!/bin/bash
################################################
# Function : Install linux-wifi-hotspot source version 
# Desc     : 用于源码方式安装linux-wifi-hotspot程序的脚本                           
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
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install linux-wifi-hotspot source version")"

echo ""
echo "Set workspace"
workspace=tools

echo ""
echo "Set soft name"
soft_name=linux-wifi-hotspot

echo ""
echo "Workspace if exits ?"
if [ ! -d ~/$workspace ];then 
    mkdir -p ~/$workspace/
fi 

echo ""
echo "Software if installed ?"
if [ -d ~/$workspace/$soft_name ];then 
    echo "$soft_name have installed" && exit 0
fi 

echo ""
echo "Install system deps"
sudo apt install -y iw
sudo apt install -y libgtk-3-dev build-essential gcc g++ pkg-config make hostapd libqrencode-dev libpng-dev

# 下载源码
echo ""
echo "Download source"
cd ~/$workspace/
git clone https://github.com/lakinduakash/linux-wifi-hotspot

cd linux-wifi-hotspot

#build binaries
make

#install
sudo make install

echo "uninstall"
echo "sudo make uninstall"

echo "USAGE:"
echo "wihotspot"


echo "Start the hotspot service on startup (using your saved configuration) with:"
echo "systemctl enable create_ap"

