#!/bin/bash
################################################
# Function : Install wsl2 xface4   
# Desc     : 用于安装WSL2桌面的脚本  
# Website  : https://www.ncnynl.com/archives/202301/5820.html                           
# Platform : WSL2 ubuntu                                
# Version  : 1.0                               
# Date     : 2022-01-10                             
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
echo "$(gettext "Install wsl2 xface4")"

echo "Install xfce4...."

sudo apt-get install xfce4
