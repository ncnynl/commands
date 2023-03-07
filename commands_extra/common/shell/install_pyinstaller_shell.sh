#!/bin/bash
################################################
# Function : Install pyinstaller shell  
# Desc     : 用于安装python打包软件pyinstaller的脚本                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-06-25 16:17:10                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install pyinstaller shell")"        

#run download pyinstaller

#check if ok 



# 下载pyinstaller包

mkdir ~/tools/

cd ~/tools/

git clone https://ghproxy.com/https://github.com/pyinstaller/pyinstaller

#run cd

cd pyinstaller 

# 进入bootloader目录

cd bootloader

#run distclean

# 生成必需文件

python3 ./waf distclean all

#run install
cd .. 

# 安装pyinstaller

sudo python3 setup.py install

