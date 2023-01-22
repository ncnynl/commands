#!/bin/bash
################################################
# Function : install autoware ade  
# Desc     : 用于安装autoware ade版本的脚本                           
# Platform : WSL2 / ubuntu                                
# Version  : 1.0                               
# Date     : 2022-01-21                             
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
# https://autowarefoundation.gitlab.io/autoware.auto/AutowareAuto/installation-ade.html
# https://ade-cli.readthedocs.io/en/latest/install.html#linux-x86-64-and-aarch64

# issue 
# [rviz2]: InvalidParametersException: Window with name 'OgreWindow(0)' already exists in GLRenderSystem::_createRenderWindow
# https://answers.ros.org/question/373765/rviz2-does-not-open-in-ubuntu-2004-docker-ade-image/
# https://github.com/ros2/rviz/issues/753
# https://github.com/osrf/docker_images/issues/105
# https://github.com/NVIDIA/nvidia-docker/issues/11#issuecomment-356802940
echo "Install autoware ade version ...."

function install_autoware_ade()
{

    echo "Build adehome"
    mkdir -p ~/adehome
    cd ~/adehome
    echo "Download autoware"
    touch .adehome
    git clone https://gitlab.com/autowarefoundation/autoware.auto/AutowareAuto.git

    echo "Use tag 1.0.0 version"
    cd AutowareAuto
    git checkout tags/1.0.0 -b release-1.0.0

    echo "Sharing files between the host system and ADE"
    cd ~
    cp ~/.bashrc ~/.bashrc.bak
    mv ~/.bashrc ~/adehome/.bashrc
    ln -s ~/adehome/.bashrc

    cd ~/adehome/AutowareAuto
    ade start --update --enter

}

install_autoware_ade

