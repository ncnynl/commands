#!/bin/bash
################################################
# Function : Install gitlfs       
# Desc     : 用于安装github大文件管理gitlfs的脚本                       
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-06-25 17:12:05                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install gitlfs")"

#https://github.com/git-lfs/git-lfs
# https://github.com/git-lfs/git-lfs/releases

echo "install git lfs"

if [ ! ~/tools ];then 
    mkdir ~/tools 
fi

filename="git-lfs-linux-amd64-v3.2.0.tar.gz"

cd ~/tools 

wget https://github.com/git-lfs/git-lfs/releases/download/v3.2.0/git-lfs-linux-amd64-v3.2.0.tar.gz

tar -zxvf git-lfs-linux-amd64-v3.2.0.tar.gz

cd git-lfs-3.2.0

sudo ./install.sh 

echo "Installed successfully , To delete tar.gz and folder git-lfs-3.2.0"
rm -rf  git-lfs-3.2.0  git-lfs-linux-amd64-v3.2.0.tar.gz

echo "Congratulations, You have successfully installed"











