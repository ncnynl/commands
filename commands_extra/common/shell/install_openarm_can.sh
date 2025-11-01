#!/bin/bash
################################################
# Function : Install openarm_can  
# Desc     : 用于安装OpenArm CAN Library                            
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2025-11-01                        
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install openarm_can")" 

#https://github.com/enactic/openarm_can

# ============================================================
# 安装依赖
# ============================================================
sudo apt update -y
sudo apt install -y git cmake build-essential can-utils iproute2

# ============================================================
# 克隆仓库
# ============================================================
WORKDIR=~/openarm_ws
REPO_URL="https://github.com/enactic/openarm_can.git"
REPO_DIR="${WORKDIR}/openarm_can"

echo "📦 准备克隆 openarm_can 源码..."
mkdir -p ${WORKDIR}
cd ${WORKDIR}

if [ -d "${REPO_DIR}" ]; then
    echo "✅ 仓库已存在，尝试更新..."
    cd ${REPO_DIR}
    git pull
else
    git clone ${REPO_URL}
    cd ${REPO_DIR}
fi

# ============================================================
# 构建源码
# ============================================================
echo "🔧 开始编译 openarm_can ..."
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build . -j$(nproc)

# ============================================================
# 安装库文件
# ============================================================
echo "🚀 安装到系统目录..."
sudo cmake --install .

# ============================================================
# 配置 CAN 环境（可选）
# ============================================================
echo "⚙️  检查 CAN 工具..."
if ! command -v ip &> /dev/null; then
    echo "❌ ip 命令未找到，请检查 iproute2 是否安装成功。"
    exit 1
fi

echo "🧩 可选：配置本地 CAN 接口（如 can0）"
echo "例如执行以下命令以启用虚拟 CAN 测试接口："
echo ""
echo "    sudo modprobe vcan"
echo "    sudo ip link add dev vcan0 type vcan"
echo "    sudo ip link set up vcan0"
echo ""
echo "或者启用真实硬件 CAN 接口："
echo ""
echo "    sudo ip link set can0 down"
echo "    sudo ip link set can0 type can bitrate 1000000"
echo "    sudo ip link set can0 up"
echo ""
echo "✅ openarm_can 已安装完成！"




