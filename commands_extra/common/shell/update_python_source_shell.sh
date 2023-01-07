#!/bin/bash
################################################
# Function : update python source shell  
# Desc     : 用于更新Python源的脚本                              
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
if [ ! -f ~/.pip/pip.conf ];then

    if [ ! -d ~/.pip ];then 
        mkdir ~/.pip
    fi 

    #run touch

    # 新建文件
    if [ ! -f ~/.pip/pip.conf ];then 
        touch ~/.pip/pip.conf 
    fi

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

    echo "add pip.conf successfull"

else
    echo "pip.conf is configured , don't need do it again!"

fi 