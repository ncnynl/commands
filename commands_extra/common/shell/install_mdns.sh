#!/bin/bash
################################################
# Function : Install mDNS
# Desc     : 用于安装mDNS的脚本                             
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2025-08-28                        
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install mDNS")" 


# install_mdns.sh
# 一键安装 Avahi，配置 mDNS，支持使用 hostname.local 访问
#
# 使用方法：
#   sudo bash install_mdns.sh            # 使用当前主机名
#   sudo bash install_mdns.sh <hostname> # 设置新的主机名
#

set -e

# 检查是否是 root
if [[ $EUID -ne 0 ]]; then
    echo "❌ 请使用 sudo 运行此脚本"
    exit 1
fi

# 获取当前主机名
CURRENT_HOSTNAME=$(hostname)

# 如果传入了新主机名，则覆盖，否则使用当前主机名
if [[ -n "$1" ]]; then
    NEW_HOSTNAME="$1"
else
    NEW_HOSTNAME="$CURRENT_HOSTNAME"
    echo "ℹ️ 未指定主机名，使用当前主机名：${NEW_HOSTNAME}"
fi

echo "🚀 开始配置 mDNS（hostname.local）支持"
echo "➡️ 目标主机名: ${NEW_HOSTNAME}"

echo "🔹 更新软件源..."
apt update -y

echo "🔹 安装 avahi-daemon 和 libnss-mdns..."
apt install -y avahi-daemon libnss-mdns

# 如果用户指定了新主机名，才更新系统主机名
if [[ "$NEW_HOSTNAME" != "$CURRENT_HOSTNAME" ]]; then
    echo "🔹 设置主机名为 ${NEW_HOSTNAME}..."
    hostnamectl set-hostname "${NEW_HOSTNAME}"
fi

# 确保 /etc/hosts 中有 127.0.1.1 映射
if ! grep -q "${NEW_HOSTNAME}" /etc/hosts; then
    # 先删除旧的 127.0.1.1 行，避免冲突
    sed -i '/^127\.0\.1\.1/d' /etc/hosts
    echo "127.0.1.1    ${NEW_HOSTNAME}" >> /etc/hosts
fi

echo "🔹 启动并启用 Avahi 服务..."
systemctl enable avahi-daemon
systemctl restart avahi-daemon

echo "🔹 检查 Avahi 服务状态..."
if systemctl is-active --quiet avahi-daemon; then
    echo "✅ Avahi 正常运行"
else
    echo "❌ Avahi 启动失败，请检查日志："
    journalctl -u avahi-daemon --no-pager | tail -20
    exit 1
fi

echo "🔹 测试 mDNS 广播服务..."
sleep 2
if avahi-browse -a | grep -q "${NEW_HOSTNAME}"; then
    echo "✅ 设备已在局域网中广播：${NEW_HOSTNAME}.local"
else
    echo "⚠️ 尚未发现 ${NEW_HOSTNAME}.local，可能需要等待几秒钟"
fi

echo
echo "🎉 配置完成！现在你可以在局域网中访问："
echo "    http://${NEW_HOSTNAME}.local"
echo "    ssh ${USER}@${NEW_HOSTNAME}.local"
echo
echo "💡 提示：如果在 Windows 上访问失败，请安装 Apple Bonjour 支持 mDNS。"

