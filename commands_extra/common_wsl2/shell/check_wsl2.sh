#!/bin/bash
################################################
# Function : Check wsl2 system   
# Desc     : 用于检查是否WSL2系统的脚本                           
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
echo "$(gettext "Check wsl2 system")"

function check_wsl()
{
    result=$(uname -a | grep "WSL2")
    if [[ "$result" != "" ]]
    then
        echo "System is WSL2 "
    else
        echo "System is not WSL2"
    fi
}
check_wsl

