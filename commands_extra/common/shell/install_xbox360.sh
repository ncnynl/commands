#!/bin/bash
################################################
# Function : Install xbox360 driver       
# Desc     : 用于安装xbox360 driver的脚本                       
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2024-08-02                         
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
# Website: https://www.ncnynl.com/archives/201610/916.html
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install xbox360 driver")"


sudo apt-add-repository ppa:rael-gc/ubuntu-xboxdrv
sudo apt-get update && sudo apt-get install ubuntu-xboxdrv










