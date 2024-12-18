#!/usr/bin/env bash
################################################
# Function : Update Docker source  
# Desc     : 用于更新 Docker 源的脚本                             
# Platform : Ubuntu                                 
# Version  : 1.1                               
# Date     : 2024-11-01                             
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL      : https://ncnynl.com                                   
# QQ Qun   : 创客智造B群:926779095                                 
# QQ Qun   : 创客智造C群:937347681                                  
# QQ Qun   : 创客智造D群:562093920                               
################################################

# 检查是否以 root 用户运行
if [ "$(id -u)" -ne 0 ]; then
  echo "请使用 root 用户或使用 sudo 运行此脚本"
  exit 1
fi

# 定义可用的 Docker 镜像源
declare -A mirrors
mirrors=(
  ["1"]="华为云镜像:https://repo.huaweicloud.com/repository/docker"
  ["2"]="腾讯云镜像:https://mirror.ccs.tencentyun.com"
  ["3"]="阿里云镜像:https://mirrors.aliyun.com"
  ["4"]="Docker Hub:https://registry-1.docker.io"
)

# 显示可用源列表
echo "请选择要使用的 Docker 镜像源:"
for key in "${!mirrors[@]}"; do
  echo "$key) ${mirrors[$key]}"
done

# 读取用户输入
read -p "请输入选择的编号: " choice

# 检查输入有效性
if [[ -z "${mirrors[$choice]}" ]]; then
  echo "无效的选择"
  exit 1
fi

# 提取用户选择的镜像源
selected_mirror="${mirrors[$choice]#*:}"

# 创建或修改 Docker 的 daemon.json 文件
DOCKER_CONFIG="/etc/docker/daemon.json"

# 创建备份
if [ -f "$DOCKER_CONFIG" ]; then
  cp "$DOCKER_CONFIG" "$DOCKER_CONFIG.bak"
fi

# 使用 sudo tee 写入新的源配置
sudo tee "$DOCKER_CONFIG" <<-EOF
{
 "registry-mirrors": [
    "$selected_mirror"
  ],
 "exec-opts": ["native.cgroupdriver=systemd"],
 "max-concurrent-downloads": 10,
 "max-concurrent-uploads": 5,
 "log-opts": {
   "max-size": "300m",
   "max-file": "2"
 },
 "live-restore": true
}
EOF

# 重启 Docker 服务
sudo systemctl restart docker

# 检查 Docker 状态和配置信息
echo "检查 Docker 状态和配置信息..."
if command -v docker &> /dev/null; then
    docker info
else
    echo "Docker 未安装或未正确配置。"
fi

echo "Docker 镜像源已更新为: $selected_mirror"
cat "$DOCKER_CONFIG"
