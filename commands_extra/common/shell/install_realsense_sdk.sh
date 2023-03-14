#!/bin/bash
################################################
# Function : Install intel realsense SDK source
# Desc     : 源码安装Intel realsense SDK的脚本                       
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-03-13                          
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
# https://gtsam.org/get_started/
#not yet support!

export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install intel realsense SDK source")"

echo "Install deps"

echo "Donlowad from github"
echo "if tools exits?"
if [ ! -d ~/tools ];then 
    mkdir ~/tools
fi 

cd ~/tools 
git clone  https://ghproxy.com/https://github.com/IntelRealSense/librealsense

# 编译代码
echo "Compile source"
cd ~/tools/librealsense

#build
mkdir build
cd build
cmake -DBUILD_EXAMPLES=true ..
make 
sudo make install

echo "librealsense have installed successfully!"