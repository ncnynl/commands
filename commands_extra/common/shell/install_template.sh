#!/bin/bash
################################################
# Function : <file_name>                        
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : <date>                          
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################

echo ""
echo "Set workspace"
workspace=<workspace_ws>

echo ""
echo "Set soft name"
soft_name=<soft_name>

echo ""
echo "Workspace if exits ?"
if [ ! -d ~/$workspace ];then 
    mkdir -p ~/$workspace/src
fi 

echo ""
echo "Software if installed ?"
if [ -d ~/$workspace/src/$soft_name ];then 
    echo "$soft_name have installed" && exit 0
fi 

echo ""
echo "Install system deps"

# 下载源码
echo ""
echo "Download source"
cd ~/$workspace/src
git clone -b <soft_branch> <soft_url>

echo ""
echo "Install rosdeps"
cd ~/$workspace/
rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y


# 编译代码
echo "Compile source"
cd ~/$workspace/
colcon build --symlink-install 


echo "Add workspace to bashrc if not exits"
if ! grep -Fq "$workspace/install/local_setup.bash" ~/.bashrc
then
    echo ". ~/$workspace/install/local_setup.bash" >> ~/.bashrc
    echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi

#How to use
