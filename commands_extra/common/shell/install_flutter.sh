#!/bin/bash
################################################
# Function : install flutter linux version
# Desc     : 用于安装flutter的脚本                           
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


cd $HOME/tools

git clone https://ghproxy.com/https://github.com/flutter/flutter.git -b stable

echo "add path to bashrc"

echo 'export PATH=$PATH:$HOME/tools/flutter/bin' >> ~/.bashrc 

echo "
  $ which flutter dart
  /path-to-flutter-sdk/bin/flutter
  /path-to-flutter-sdk/bin/dart
"
echo "Congratulations, flutter have successfully installed"
