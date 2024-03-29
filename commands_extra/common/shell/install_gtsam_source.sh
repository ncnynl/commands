#!/bin/bash
################################################
# Function : Install gtsam from source
# Desc     : 通过源码安装gtsam C++库的脚本                       
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
echo "$(gettext "Install gtsam from source")"


echo "Install deps"
sudo apt-get install libboost-all-dev -y
sudo apt-get install cmake -y
sudo apt-get install libtbb-dev -y 

echo "Donlowad from github"
echo "if tools exits?"
if [ ! -d ~/tools ];then 
    mkdir ~/tools
fi 

cd ~/tools 
git clone  -b 4.1.0 https://github.com/borglab/gtsam

# 编译代码
echo "Compile source"
cd ~/tools/gtsam

#disable TBB from CMakelist.txt
# find_package(TBB 4.4 COMPONENTS tbb tbbmalloc)

#build
mkdir build
cd build
cmake -DGTSAM_WITH_TBB=OFF ..
make install

echo "gtsam have installed successfully!"

