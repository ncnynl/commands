#!/bin/bash
################################################
# Function : Install snowboy docker  
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
echo "$(gettext "Install snowboy docker")" 
# echo "Not Supported Yet!"
# exit 0  
echo "Set workspace"
workspace=tools

echo ""
echo "Set soft name"
soft_name=snowboy-new

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
#install docker 
rcm -si install_docker.sh

echo ""
echo "Download source"
cd ~/$workspace/
git clone https://gitee.com/ncnynl/snowboy-new

#build zh
cd ~/$workspace/snowboy-new/docker/zh
docker build -t snowboy-pmdl-zh .

#build en 
cd ~/$workspace/snowboy-new/docker/en
docker build -t snowboy-pmdl-en .

echo "Please continue to finished code"

