#!/bin/bash
################################################
# Function : check_echo_shell.sh                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-06-28 19:14:02                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
        
#https://github.com/balena-io/etcher/releases/tag/v1.10.1
#https://github.com/balena-io/etcher/releases

#version
version=1.8.17
filename=balenaEtcher-$version-x64.AppImage

#
cd ~/tools
rm -rf $filename

#download
# wget https://ghproxy.com/https://github.com/balena-io/etcher/releases/download/v1.10.1/balenaEtcher-1.10.1-x64.AppImage
wget https://ghproxy.com/https://github.com/balena-io/etcher/releases/download/v$version/balenaEtcher-$version-x64.AppImage
#别名
rm -rf balenaEtcher
ln -s $filename balenaEtcher
chmod +x balenaEtcher

echo "Run balenaEtcher  cd ~/tools ; ./balenaEtcher"

