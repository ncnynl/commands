#!/bin/bash
################################################
# Function : Install cockpit 
# Desc     : 用于APT方式安装cockpit配置wifi的脚本                           
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
echo "$(gettext "Install cockpit")"

echo ""
# sudo apt update
# sudo apt install cockpit -y

echo "ref:https://cockpit-project.org/running.html#ubuntu"
. /etc/os-release
sudo apt-get install cockpit -t ${VERSION_CODENAME}-backports


echo "start service"
sudo systemctl start cockpit
sudo systemctl enable cockpit



echo "USAGE:"
echo "http://localhost:9090"