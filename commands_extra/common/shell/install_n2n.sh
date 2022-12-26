#!/bin/bash
################################################
# Function : install_n2n                        
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
# echo "Not Supported Yet!"
# exit 0  
echo "Website: https://www.ncnynl.com/archives/202205/5233.html"
echo "Set workspace"
workspace=tools

echo ""
echo "Set soft name"
soft_name=n2n

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

# 下载源码
echo ""
echo "Download source"
cd ~/$workspace/
git clone -b 3.0-stable https://ghproxy.com/https://github.com/ntop/n2n n2n-3.0

echo ""
echo "Install rosdeps"
cd n2n-3.0

# 编译代码
echo "Compile source"
./autogen.sh
./configure
make

echo "Please continue to finished code"
#How to use
