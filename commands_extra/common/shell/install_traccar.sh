#!/bin/bash
################################################
# Function : Install GPS traccar server
# Desc     : 用于源码方式安装GPS traccar程序的脚本                           
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2024-12-19                            
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
echo "$(gettext "Install GPS traccar server")"

echo ""
echo "Set workspace"
workspace=tools

echo ""
echo "Set soft name"
soft_name=traccar

echo ""
echo "Workspace if exits ?"
if [ ! -d ~/$workspace ];then 
    mkdir -p ~/$workspace/
fi 

echo ""
echo "Software if installed ?"
if [ -d ~/$workspace/$soft_name ];then 
    echo "$soft_name have installed" && exit 0
fi 

echo ""
echo "Install system deps"
sudo apt install openjdk-11-jdk

# 下载源码
echo ""
echo "Download source"
cd ~/$workspace/
# 下载 Traccar 安装包
wget https://github.com/traccar/traccar/releases/download/v6.5/traccar-linux-64-6.5.zip
# 解压安装包

unzip -d traccar traccar-linux-64-6.5.zip

cd traccar
sudo ./traccar.run

echo "Start the traccar service on startup (using your saved configuration) with:"
echo "sudo systemctl start traccar"


# https://www.traccar.org/linux/

# Install
# Download and extract the installer package
# Execute traccar.run file
# sudo ./traccar.run
# Start systemd service
# sudo systemctl start traccar


# Uninstall
# Stop systemd service
# sudo systemctl stop traccar
# Remove systemd service
# sudo systemctl disable traccar
# sudo rm /etc/systemd/system/traccar.service
# sudo systemctl daemon-reload
# Remove traccar directory
# sudo rm -R /opt/traccar

