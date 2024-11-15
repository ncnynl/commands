#!/bin/bash
################################################
# Function : Install todesk  
# Desc     : 用于安装远程桌面软件todesk的脚本                             
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2024-11-15 17:12:05                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# URL: https://www.todesk.com/linux.html                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install todesk")" 

if [ -f /etc/todesk ];then 
    echo "todesk have installed!!" 
fi  


echo "Install deps:"

sudo apt install libappindicator3-dev

echo "Download todesk"

cd ~/tools

wget https://dl.todesk.com/linux/todesk-v4.7.2.0-amd64.deb

sudo apt-get install ./todesk-v4.7.2.0-amd64.deb

echo "USAGE: todesk "

