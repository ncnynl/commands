#!/bin/bash
################################################
# Function : Install balenaEtcher   
# Desc     : 用于安装烧录软件balenaEtcher的脚本                             
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
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install balenaEtcher")"           
#https://github.com/balena-io/etcher/releases/tag/v1.10.1
#https://github.com/balena-io/etcher/releases


#deps 
#for >= ubuntu 22.04
if [ $version -ge "22.04" ];then 
    sudo add-apt-repository universe
    sudo apt install libfuse2
else  #for < ubuntu 22.04
    sudo apt install fuse libfuse2 
    sudo modprobe fuse 
    sudo groupadd fuse 

    user="$(whoai)"
    sudo usermod -a -G fuse $user 
fi

#version
version=1.8.17
filename=balenaEtcher-$version-x64.AppImage

#
cd ~/tools
rm -rf $filename

#download
# wget https://github.com/balena-io/etcher/releases/download/v1.10.1/balenaEtcher-1.10.1-x64.AppImage
wget https://github.com/balena-io/etcher/releases/download/v$version/balenaEtcher-$version-x64.AppImage
#别名
rm -rf balenaEtcher
ln -s $filename balenaEtcher
chmod +x balenaEtcher

echo "Run balenaEtcher  cd ~/tools ; ./balenaEtcher"

