#!/bin/bash
################################################
# Function : Install GitHubDesktop shell   
# Desc     : 用于安装github仓库管理软件GitHubDesktop的脚本                            
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-06-25 14:14:16                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install GitHubDesktop shell")"        

#run get github desktop

# 下载GitHubDesktop工具

sudo wget https://ghproxy.com/https://github.com/shiftkey/desktop/releases/download/release-2.9.3-linux3/GitHubDesktop-linux-2.9.3-linux3.deb

#run install gdebi

# 安装github桌面工具

sudo apt-get install gdebi-core 

#run GitHubDesktop

# 安装GitHubDesktop工具

sudo gdebi GitHubDesktop-linux-2.9.3-linux3.deb

#run clear

# 清除多余文件
sudo rm  -r GitHubDesktop-linux-2.9.3-linux3.deb  wget-log

