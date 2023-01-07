#!/bin/bash
################################################
# Function : install n2n  
# Desc     : 用于安装搭建异域局域网软件n2n的脚本                        
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
sudo apt install autogen autoconf -y

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
#for ubuntu 15.4.3.6  
# cd ~/tools/n2n-3.0
# sudo ./supernode -p 5000 -f -vvv -S1

#for ubuntu A
# cd ~/tools/n2n-3.0
# sudo ./edge -a 10.0.0.3 -c g1 -k test -l 15.4.3.6:5000 -f -vvv -S1

#for windows B
# cd C:\n2n_v3_windows_x64_v3.1.1-16_r1200_static_by_heiye #need admin 
# edge.exe -a 10.0.0.4 -c g1 -k test -l 15.4.3.6:5000 -vvv -S1