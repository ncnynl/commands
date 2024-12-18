#!/bin/bash
################################################
# Function : Install arduino  
# Desc     : 用于安装arduino IDE的脚本                                
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-11-19                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                          
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install arduino")"   

sudo apt install arduino -y 



