#!/bin/bash
################################################
# Function : Install VMWare Tools  
# Desc     : 用于安装VMWare Tools的脚本                             
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2025-07-14                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install VMware Tools")" 

sudo apt install open-vm-tools open-vm-tools-desktop -y

