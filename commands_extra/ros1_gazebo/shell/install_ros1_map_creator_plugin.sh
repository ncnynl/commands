#!/bin/bash
################################################
# Function : Install ROS1 collision_map_creator_plugin source 
# Desc     : 用于源码方式安装ROS1版本collision_map_creator_plugin的脚本                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-08-29 15:25:09                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920        
# website: https://classic.gazebosim.org/tutorials?tut=custom_messages&cat=transport                       
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ROS1 collision_map_creator_plugin source ")"


# if installed ?
if [ -d ~/tools/collision_map_creator_plugin ]; then
    echo "collision_map_creator_plugin have installed!!" 
else 

    # install dep
    sudo apt-get -y install protobuf-compiler

    # 新建工作空间
    if [ ! -d ~/tools ]; then
        mkdir -p ~/tools/
    fi 

    # 进入工作空间
    cd ~/tools/

    # 获取仓库列表
    #run import
    echo "this will take serveral min to download"
    # 下载仓库
    echo "Dowload collision_map_creator_plugin"
    git clone  https://gitee.com/ncnynl/collision_map_creator_plugin
    cd collision_map_creator_plugin
    mkdir build
    cd build
    cmake ../
    make

    # 添加GAZEBO_PLUGIN_PATH到bashrc文件
    echo "Add workspace to bashrc"
    if ! grep -Fq "collision_map_creator_plugin" ~/.bashrc
    then
        echo 'export GAZEBO_PLUGIN_PATH=$GAZEBO_PLUGIN_PATH:~/tools/collision_map_creator_plugin/build' >> ~/.bashrc
    fi

fi