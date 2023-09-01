#!/bin/bash
################################################
# Function : Install Beyond Compare
# Desc     : 用于安装文件比较工具的脚本                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-09-01 18:12:05                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install Beyond Compare")"         

echo "This will take a while to download"
wget https://www.scootersoftware.com/bcompare-4.4.6.27483_amd64.deb
sudo apt update

echo "Install Beyond Compare v4.4.6"
sudo apt install ./bcompare-4.4.6.27483_amd64.deb

echo "installed succ, If want to delete , run sudo apt remove bcompare "
#Terminal Uninstall
#sudo apt remove bcompare
