#!/usr/bin/env bash
################################################
# Function : Update system time  
# Desc     : 用于更新系统时间的脚本                             
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-03-18 17:12:05                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Update system time")" 


echo "Install ntpdate"
sudo apt install ntpdate


echo "Update time"
sudo ntpdate ntp.ubuntu.com



