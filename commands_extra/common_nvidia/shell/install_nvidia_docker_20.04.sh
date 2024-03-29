#!/bin/bash
################################################
# Function : Install nvidia docker 20.04   
# Desc     : 用于安装nvidia docker的脚本                           
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
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install nvidia docker 20.04")"

echo "Install Nvidia docker...."

function install_nvidia_docker_v2()
{
    
    # distribution=$(. /etc/os-release;echo $ID$VERSION_ID) 
    distribution="ubuntu20.04" \
    && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
    && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

    sudo apt update

    sudo apt install -y nvidia-docker2

    sudo groupadd docker			# 有则不用创建
    sudo usermod -aG docker $USER	# USER 为加入 docker 组的用户
    newgrp docker					# 刷新 docker 组
    # docker run hello-world			# 测试无 root 权限能否使用 docker

    # sudo systemctl restart docker
    sudo service docker restart
    sudo service docker start 
    echo "Test this for nvidia docker"
    docker run --rm --gpus all nvidia/cuda:11.6.2-base-ubuntu20.04 nvidia-smi

}
install_nvidia_docker_v2

