#!/bin/bash
################################################
# Function : Install docker 
# Desc     : 用于安装容器docker的脚本                               
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-10-29 17:17:58                            
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
echo "$(gettext "Install docker")"
        
echo "Install Curl"
sudo apt install curl -y 

echo "安装最新版本的docker"
curl sSL https://get.docker.com | sh
sudo service docker start

echo "无root 权限能否使用 docker"
sudo groupadd docker			# 有则不用创建
sudo usermod -aG docker $USER	# USER 为加入 docker 组的用户
newgrp docker					# 刷新 docker 组    

echo "Check Docker version"
docker --version 

# docker run hello-world			# 测试无 root 权限能否使用 docker


# 检查dockerd进程启动
# service docker status
# ps aux|grep docker
# # 检查拉取镜像等正常
# docker pull busybox
# docker images