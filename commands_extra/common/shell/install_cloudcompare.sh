#!/bin/bash
################################################
# Function : Install cloudcompare from snap
# Desc     : 通过snap安装cloudcompare的脚本                       
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-12-10                          
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
# https://gtsam.org/get_started/
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install cloudcompare from snap")"

sudo snap install cloudcompare 