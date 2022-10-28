#!/bin/bash
################################################
# Function : update_python_source_shell.sh                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-06-24 15:17:32                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
        

#run mkdir

# 新建目录

mkdir ~/.pip

#run touch

# 新建文件

touch ~/.pip/pip.conf 

#run echo

# 添加内容

echo "[global]" >> ~/.pip/pip.conf 

#run echo

# 添加内容

echo "index-url = http://pypi.douban.com/simple" >> ~/.pip/pip.conf 

#run echo

# 添加内容

echo "[install] " >> ~/.pip/pip.conf

#run echo

# 添加内容

echo "trusted-host=pypi.douban.com" >> ~/.pip/pip.conf

