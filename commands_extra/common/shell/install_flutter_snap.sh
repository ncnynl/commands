#!/bin/bash
################################################
# Function : Install flutter snap version
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
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install flutter snap version")"
# https://www.cyberithub.com/how-to-install-flutter-on-ubuntu-20-04-lts-focal-fossa/
# https://docs.flutter.dev/community/china
# https://flutter.cn/docs/get-started/install/linux

echo "Install flutter from snap"

sudo snap install flutter --classic

sudo snap alias flutter.dart dart

echo "Install  android-studio"

sudo snap install android-studio --classic

flutter config --android-studio-dir /snap/android-studio/current/android-studio

echo "Install androidsdk"
# https://stackoverflow.com/questions/34556884/how-to-install-android-sdk-on-ubuntu
sudo snap install androidsdk

flutter config --android-sdk $HOME/AndroidSDK

androidsdk "platform-tools" "platforms;android-32" "build-tools;30.0.3" "cmdline-tools;latest"

# echo "add path to bashrc"
# echo 'export PUB_HOSTED_URL=https://pub.flutter-io.cn' >> ~/.bashrc 
# echo 'export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn' >> ~/.bashrc 
# echo 'export FLUTTER_GIT_URL=https://ghproxy.com/https://github.com/flutter/flutter.git' >> ~/.bashrc 

export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
# export FLUTTER_GIT_URL=https://ghproxy.com/https://github.com/flutter/flutter.git
export FLUTTER_GIT_URL=https://github.com/flutter/flutter.git

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

# https://stackoverflow.com/questions/51281702/unable-to-find-bundled-java-version-on-flutter
# Unable to find bundled Java version
# cd ~/android-studio/ && ln -s jbr jre

flutter doctor

# mkdir flutter_example
# cd flutter_example
# flutter create .
# flutter run -d linux

echo "Congratulations, flutter have successfully installed"
