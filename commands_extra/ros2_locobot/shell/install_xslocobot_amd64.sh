#!/bin/bash
################################################
# Function : Install_interbotix_xslocobot           
# Desc     : 安装Interbotix X-Series locobot的脚本
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2024-07-09 15:17:32                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install_interbotix_xslocobot")"


cd "${HOME}/commands/ros2_locobot/resource"
./xslocobot_amd64_install.sh -b create3