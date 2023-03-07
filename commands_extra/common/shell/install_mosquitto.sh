#!/bin/bash
################################################
# Function : Install mosquitto 
# Desc     : 用于安装MQTT服务器mosquitto的脚本                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-06-28 19:14:02                            
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
echo "$(gettext "Install mosquitto")"          

echo "Install mosquitto"

sudo apt install -y mosquitto mosquitto-clients


