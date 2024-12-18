#!/bin/bash
################################################
# Function : Install chrome linux version
# Desc     : 用于deb方式安装chrome的脚本     
# Website  : https://itsfoss.com/install-chrome-ubuntu/                       
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-02-01                         
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install chrome linux version")"  

echo "Install chrome from deb"

cd ~

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo dpkg -i google-chrome-stable_current_amd64.deb

sudo ln -s /usr/bin/google-chrome-stable /usr/bin/google-chrome

rm -rf google-chrome-stable_current_amd64.deb

echo "Congratulations, chrome have successfully installed"
