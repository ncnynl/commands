#!/bin/bash
################################################
# Function : Install gtsam from PPA
# Desc     : 通过PPA安装gtsam C++库的脚本                       
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
echo "$(gettext "Install gtsam from PPA")"

#test for 22.04

echo "Add PPA"
sudo add-apt-repository ppa:borglab/gtsam-release-4.1

echo "update"
sudo apt update  # not necessary since Bionic

echo "Install"
sudo apt install libgtsam-dev libgtsam-unstable-dev