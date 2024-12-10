#!/bin/bash
################################################
# Function : Update swapfile  
# Desc     : 脚本会检查当前的 swapfile 大小是否已经大于或等于内存的两倍，如果满足条件，则不进行任何操作。否则，它将创建一个新的 swapfile，大小为内存的两倍                          
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2024-12-10                         
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################

# 获取总内存大小（以 MB 为单位）
MEMORY_SIZE_MB=$(grep MemTotal /proc/meminfo | awk '{printf "%.0f", $2 / 1024}')
TARGET_SWAP_SIZE_MB=$(awk -v mem="$MEMORY_SIZE_MB" 'BEGIN { print int(mem * 2) }')

# 获取当前 swapfile 大小（以 MB 为单位）
SWAPFILE=/swapfile
CURRENT_SWAP_SIZE_MB=0
if [ -f $SWAPFILE ]; then
    CURRENT_SWAP_SIZE_MB=$(du -m $SWAPFILE | awk '{print $1}')
fi

echo "内存大小：${MEMORY_SIZE_MB} MB"
echo "目标交换文件大小：${TARGET_SWAP_SIZE_MB} MB"
echo "当前交换文件大小：${CURRENT_SWAP_SIZE_MB} MB"

# 如果当前交换文件大小已经大于或等于目标大小，则退出
if (( CURRENT_SWAP_SIZE_MB >= TARGET_SWAP_SIZE_MB )); then
    echo "当前交换文件大小已经大于或等于内存的两倍（${TARGET_SWAP_SIZE_MB} MB），无需更新。"
    exit 0
fi

# 禁用当前交换文件
if swapon --show | grep -q $SWAPFILE; then
    echo "禁用当前交换文件..."
    sudo swapoff $SWAPFILE
fi

# 删除旧的交换文件
if [ -f $SWAPFILE ]; then
    echo "删除旧的交换文件..."
    sudo rm $SWAPFILE
fi

# 创建新的交换文件
echo "创建新的交换文件（大小：${TARGET_SWAP_SIZE_MB} MB）..."
sudo fallocate -l ${TARGET_SWAP_SIZE_MB}M $SWAPFILE

# 设置权限
echo "设置交换文件权限..."
sudo chmod 600 $SWAPFILE

# 设置交换区域
echo "设置交换区域..."
sudo mkswap $SWAPFILE

# 启用新的交换文件
echo "启用新的交换文件..."
sudo swapon $SWAPFILE

# 验证交换文件状态
echo "交换文件状态："
swapon --show

# 确保交换文件在重启后生效
if ! grep -q "$SWAPFILE" /etc/fstab; then
    echo "更新 /etc/fstab 文件以确保交换文件生效..."
    echo "$SWAPFILE none swap sw 0 0" | sudo tee -a /etc/fstab
fi

echo "交换文件已更新为内存的两倍大小（${TARGET_SWAP_SIZE_MB} MB）。"
