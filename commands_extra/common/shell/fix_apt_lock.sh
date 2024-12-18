#!/bin/bash
################################################
# Function : Fix apt lock issue  
# Desc     : 用于解决apt安装出现的lock问题的脚本                             
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-04-27 17:12:05                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Fix apt lock")" 

echo "Kill lock file"
sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock*

echo "then reconfigure the packages. Run in terminal:"
sudo dpkg --configure -a

echo "update" 
sudo apt update