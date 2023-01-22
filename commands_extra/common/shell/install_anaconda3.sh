#!/bin/bash
################################################
# Function : install Anaconda3   
# Desc     : 用于安装Anaconda3的脚本                           
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-06-28 19:14:02                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
# https://www.anaconda.com/products/distribution#Downloads


echo "Install Anaconda3-2022.10-Linux-x86_64 ..."

cd ~

echo "Download Anaconda3 and rename to Anaconda3.sh"
wget -O Anaconda3.sh https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh
chmod +x Anaconda3.sh 

echo "Install Anaconda3.sh"
./Anaconda3.sh

echo "Delete Anaconda3.sh"
rm ~/Anaconda3.sh 
