#!/bin/bash
################################################
# Function : Install snowboy  
# Desc     : 用于安装唤醒词程序snowboy
# Website  : https://www.ncnynl.com/archives/202203/5107.html                      
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-12-26                          
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT           
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.                      
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install snowboy")" 
# echo "Not Supported Yet!"
# exit 0  
echo "Set workspace"
workspace=tools

echo ""
echo "Set soft name"
soft_name=snowboy

echo ""
echo "Workspace if exits ?"
if [ ! -d ~/$workspace ];then 
    mkdir -p ~/$workspace
fi 

echo ""
echo "Software if installed ?"
if [ -d ~/$workspace/$soft_name ];then 
    echo "$soft_name have installed" && exit 0
fi 

echo ""
echo "Install system deps"
sudo apt -y update
sudo apt install portaudio19-dev python3-pyaudio sox pulseaudio libsox-fmt-all -y
sudo apt install  ffmpeg -y
sudo apt install libpcre3 libpcre3-dev  libatlas-base-dev -y
pip3 install pyaudio fire -y

echo ""
echo "Download source"
cd ~/$workspace/
git clone https://gitee.com/ncnynl/snowboy-new


echo "Install swig"
cd ~/tools/snowboy-new
# wget https://wzpan-1253537070.cos.ap-guangzhou.myqcloud.com/misc/swig-3.0.10.tar.gz
tar xvf swig-3.0.10.tar.gz
cd swig-3.0.10
./configure --prefix=/usr --without-clisp --without-maximum-compile-warnings
make
sudo make install
sudo install -v -m755 -d /usr/share/doc/swig-3.0.10
sudo cp -v -R Doc/* /usr/share/doc/swig-3.0.10

echo "Install snowboy-new"
cd ~/tools/snowboy-new/swig/Python3
make

echo "Please continue to finished code"
#How to use
