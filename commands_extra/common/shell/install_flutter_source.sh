#!/bin/bash
################################################
# Function : install flutter linux version
# Desc     : 用于源码安装flutter的脚本                           
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-02-01                         
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
# https://www.cyberithub.com/how-to-install-flutter-on-ubuntu-20-04-lts-focal-fossa/
# https://docs.flutter.dev/community/china
# https://flutter.cn/docs/get-started/install/linux

echo "Install flutter source"
cd $HOME/tools

git clone https://ghproxy.com/https://github.com/flutter/flutter.git -b stable

echo "add path to bashrc"
echo 'export PATH=$PATH:$HOME/tools/flutter/bin' >> ~/.bashrc 
echo 'export PUB_HOSTED_URL=https://pub.flutter-io.cn' >> ~/.bashrc 
echo 'export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn' >> ~/.bashrc 
echo 'export FLUTTER_GIT_URL=https://ghproxy.com/https://github.com/flutter/flutter.git' >> ~/.bashrc 

export PATH=$PATH:$HOME/tools/flutter/bin
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export FLUTTER_GIT_URL=https://ghproxy.com/https://github.com/flutter/flutter.git

which flutter dart

echo "Congratulations, flutter have successfully installed"
