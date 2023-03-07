#!/bin/bash
################################################
# Function : Config snap for wsl2    
# Desc     : 用于配置在wsl2下使用snap的脚本 
# Website  : https://github.com/microsoft/WSL/issues/5126                       
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
echo "$(gettext "Config snap for wsl2")"

# echo "Config bashrc ...."
sudo apt-get update && sudo apt-get install -yqq daemonize dbus-user-session fontconfig
sudo daemonize /usr/bin/unshare --fork --pid --mount-proc /lib/systemd/systemd --system-unit=basic.target
exec sudo nsenter -t $(pidof systemd) -a su - $LOGNAME



