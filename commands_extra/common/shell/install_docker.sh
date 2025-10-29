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

set -e  # 遇到错误时终止脚本

echo "===== 安装 curl ====="
sudo apt update
sudo apt install -y curl

echo "===== 安装最新版本 Docker ====="
curl -fsSL https://get.docker.com | sh

echo "===== 启动并开机自启 Docker ====="
sudo systemctl enable --now docker

echo "===== 配置当前用户无 root 使用 docker ====="
sudo groupadd docker || true  # 如果已存在则忽略错误
sudo usermod -aG docker $USER
newgrp docker

echo "===== 检查 Docker 版本 ====="
docker --version

echo "===== 检查 Docker Compose 版本 ====="
docker compose version || echo "docker compose 尚未安装（可执行下一步手动安装）"

echo "===== 如果 docker-compose 没安装，可执行以下命令 ====="
echo "sudo apt install -y docker-compose-plugin"

echo "===== 测试 Docker 是否正常工作 ====="
docker run hello-world

echo "✅ Docker 安装完成！请重新登录或执行 newgrp docker 后再使用。"

