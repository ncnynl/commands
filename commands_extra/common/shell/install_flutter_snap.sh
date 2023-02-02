#!/bin/bash
################################################
# Function : install flutter snap version
# Desc     : 用于snap方式安装flutter的脚本     
# Website  : https://ubuntu.com/blog/getting-started-with-flutter-on-ubuntu                         
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

echo "Install flutter from snap"

sudo snap install flutter --classic

sudo snap alias flutter.dart dart

echo "Install  android-studio"

sudo snap install android-studio --classic

flutter config --android-studio-dir /snap/android-studio/current/android-studio

flutter doctor --android-licenses

# switch to dev branch
# flutter channel dev
# update Flutter to the latest dev branch revision
# flutter upgrade
# enable Linux toolchain
flutter config --enable-linux-desktop
# enable macOS toolchain
# flutter config --enable-macos-desktop
# enable Windows toolchain
# flutter config --enable-windows-desktop

flutter doctor

# mkdir flutter_example
# cd flutter_example
# flutter create .
# flutter run -d linux

echo "Congratulations, flutter have successfully installed"
