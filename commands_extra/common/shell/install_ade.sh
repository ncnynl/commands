#!/bin/bash
################################################
# Function : Install ade   
# Desc     : 用于安装ade的脚本                           
# Platform : WSL2 / ubuntu                                
# Version  : 1.0                               
# Date     : 2022-01-21                             
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
echo "$(gettext "Install ade")"


function install_ade()
{
    BIN="/usr/local/bin"
    cd ~
    wget https://gitlab.com/ApexAI/ade-cli/-/jobs/1341322851/artifacts/raw/dist/ade+x86_64
    sudo mv ade+x86_64 "${BIN}/ade"
    sudo chmod +x "${BIN}/ade"

    echo "Check version"
    ade --version
    
    echo "Update ade"
    sudo ade update-cli

    echo "Check version again"
    ade --version
}

install_ade

