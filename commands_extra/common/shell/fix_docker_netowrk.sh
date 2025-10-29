#!/bin/bash
################################################
# Function : Fix Docker network access & add mirrors
# Desc     : 自动添加国内镜像源 + DNS + 网络检测
# Platform : Ubuntu / Debian / 兼容系统                              
# Version  : 1.0                               
# Date     : 2025-10-09                        
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
echo "$(gettext "Fix Docker network")"

set -e

echo "===== Docker 网络加速修复工具 ====="

# 检查 Docker 是否安装
if ! command -v docker &> /dev/null; then
    echo "❌ 未检测到 Docker，请先执行安装脚本。"
    exit 1
fi

echo "===== Step 1. 创建 /etc/docker/daemon.json ====="
sudo mkdir -p /etc/docker

sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": [
    "https://docker.m.daocloud.io",
    "https://mirror.ccs.tencentyun.com",
    "https://registry.docker-cn.com"
  ],
  "dns": ["8.8.8.8", "1.1.1.1"]
}
EOF

echo "✅ 镜像加速源已写入 /etc/docker/daemon.json"

echo "===== Step 2. 重新加载并重启 Docker 服务 ====="
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl restart docker

# 检查 Docker 状态
if systemctl is-active --quiet docker; then
    echo "✅ Docker 服务已启动"
else
    echo "❌ Docker 服务启动失败，请检查 systemctl status docker"
    exit 1
fi

echo "===== Step 3. 测试网络连通性 ====="
if curl -s --connect-timeout 5 https://registry-1.docker.io/v2/ > /dev/null; then
    echo "🌍 Docker Hub 网络连接正常"
else
    echo "⚠️ 无法直连 Docker Hub，正在使用国内镜像源"
fi

echo "===== Step 4. 测试拉取镜像 ====="
if docker run --rm hello-world; then
    echo "🎉 测试成功：Docker 网络与镜像加速配置正常！"
else
    echo "⚠️ 仍然无法拉取镜像，可能是防火墙或代理问题。"
    echo "👉 可尝试：sudo systemctl restart docker 再试一次。"
fi

echo "✅ Docker 网络加速修复完成。"


