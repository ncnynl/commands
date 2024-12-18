#!/bin/bash
################################################
# Function : Install gettext       
# Desc     : 用于安装gettext实现shell国际化的脚本                       
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-03-09 17:12:05                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install gettext")"

# https://www.gnu.org/software/gettext/


sudo apt update
sudo apt install gettext

echo "Congratulations, You have successfully installed"











