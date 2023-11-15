#!/bin/bash
################################################
# Function : Install osqp   
# Desc     : 用于安装osqp的脚本                           
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
echo "$(gettext "Install osqp")"

# https://github.com/osqp/osqp/releases/download/v0.6.2/complete_sources.tar.gz
# https://osqp.org/docs/get_started/sources.html#install-the-binaries

function install_osqp()
{
    cd ~/tools
    wget https://github.com/osqp/osqp/releases/download/v0.6.2/complete_sources.tar.gz
    tar -zxvf complete_sources.tar.gz
    cd ~/tools/osqp
    mkdir build
    cd build
    cmake -G "Unix Makefiles" ..
    sudo cmake --build . --target install
}
install_osqp
