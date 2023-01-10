#!/bin/bash
################################################
# Function : <file_name>  
# Desc     : 用于生成脚本的模板                      
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : <date>                          
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
echo ""
echo "Set workspace"
workspace=<workspace_ws>

echo ""
echo "Set soft name"
soft_name=<soft_name>

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
git clone -b <soft_branch> <soft_url>

echo ""
echo "Install rosdeps"


# 编译代码
echo "Compile source"

echo "Please continue to finished code"
#How to use
