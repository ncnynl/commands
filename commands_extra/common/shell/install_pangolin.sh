#!/bin/bash
################################################
# Function : Install Pangolin source version
# Desc     : 用于源码方式安装Pangolin的脚本                       
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-12-10                          
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
echo "$(gettext "Install Pangolin source version")"
# 
echo "Not Supported Yet!"
exit 0  
echo ""
echo "Set workspace"
workspace=tools

echo ""
echo "Set soft name"
soft_name=Pangolin

echo ""
echo "Workspace if exits ?"
if [ ! -d ~/$workspace ];then 
    mkdir -p ~/$workspace
fi 

echo ""
echo "Software if installed ?"
if [ -d ~/$workspace/Pangolin ];then 
    echo "$soft_name have installed" && exit 0
fi 

echo ""
echo "Install system deps"

# 下载源码
echo ""
echo "Download source"
cd ~/$workspace
git clone https://github.com/stevenlovegrove/Pangolin

# 编译代码
echo "Compile source"
cd Pangolin
mkdir build
cd build
cmake -DCPP11_NO_BOOST=1 ..
make

#How to use
