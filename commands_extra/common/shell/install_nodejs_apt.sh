#!/bin/bash
################################################
# Function : Install nodejs apt version 
# Desc     : 用于安装APT的nodejs版本                          
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2024-12-18                             
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install nodejs apt version")" 

curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

sudo apt install nodejs

node -v 

npm -v 

echo "Congratulations, nodejs and yarn have successfully installed"