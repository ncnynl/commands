#!/bin/bash
################################################
# Function : install_sunlogin 
# Desc     : 安装向日葵linux版本的脚本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Wed Sep 13 05:05:39 PM CST 2023                            
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
echo "$(gettext "install_sunlogin")"

echo "This script is under DEV state !"

function rcm_execute() {
    echo "Download sunlogin "
    cd ~/tools/
    wget https://down.oray.com/sunlogin/linux/SunloginClient_11.0.1.44968_amd64.deb

    echo "Install sunlogin"
    sudo dpkg -i SunloginClient_11.0.1.44968_amd64.deb

    echo "Finished , please click show applications search with name sunlogin!"
}

# Execute current script
rcm_execute $*