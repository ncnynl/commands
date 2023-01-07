#!/bin/bash
################################################
# Function : install cubic
# Desc     : 用于安装自定义镜像软件Cubic的脚本                             
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-11-21                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################

#usage:https://www.ncnynl.com/archives/202210/5484.html
echo "Add Cubic ppa" 
sudo apt-add-repository ppa:cubic-wizard/release 
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6494C6D6997C215E


echo "Install cubic"
sudo apt update && sudo apt install cubic -y 

echo "Create cubic folders"
if [ ! -d ~/cubic/iso ];then
    echo "iso folder for downloading ubuntu origin iso" 
    mkdir -p ~/cubic/iso

    echo "build folder for creating custom new iso"
    mkdir -p ~/cubic/build
fi 

echo "Cubic Installed successfully!"