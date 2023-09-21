#!/bin/bash
################################################
# Function : install_odrive 
# Desc     : 用于安装0.5.1版本odrivetool脚本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Wed Sep 20 10:44:44 AM CST 2023                            
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
echo "$(gettext "install_odrive")"

echo "This script is under DEV state !"

function rcm_execute() {
    echo "Install odrivetool 0.5.1 here!"
    
    pip install odrive==0.5.1.post0

    echo "add udev rules" 
    echo "SUBSYSTEM=="usb", ATTR{idVendor}=="1209", ATTR{idProduct}=="0d3[0-9]", MODE="0666", ENV{ID_MM_DEVICE_IGNORE}="1"" | sudo tee /etc/udev/rules.d/91-odrive.rules
    echo "SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="df11", MODE="0666"" | sudo tee -a /etc/udev/rules.d/91-odrive.rules

    echo "reload-rules"
    sudo udevadm control --reload-rules

    echo "restart udev"
    sudo systemctl restart udev

    echo "run as : odrivetool "    
}

# Execute current script
rcm_execute $*