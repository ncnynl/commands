#!/bin/bash
################################################
# Function : launch wsl2 xface4   
# Desc     : 用于自动配置和启动xfce的脚本 
# Website  : https://www.ncnynl.com/archives/202301/5820.html                          
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

# echo "Config bashrc ...."
CHOICE_A=$(echo -e "Please input your windows ip, Check with ipconfig from powershell (Like: 192.168.1.105)：")
read -p "${CHOICE_A}" win_ip
if [ -z "${win_ip}" ]; then
    echo "win_ip can not be null"
    exit 0
fi

replace="export DISPLAY=${win_ip}:0.0"

if ! grep -Fq "export DISPLAY" ~/.bashrc
then
    echo $replace >> ~/.bashrc
else
    sed -i "s/^.*DISPLAY=.*$/$replace/g" ~/.bashrc 
fi
echo "Start xfce4"
export DISPLAY=${win_ip}:0.0
startxfce4
