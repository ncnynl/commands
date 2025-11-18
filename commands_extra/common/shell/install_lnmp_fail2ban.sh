#!/bin/bash
###########################################################
# Function : Install Fail2ban from source + UFW support
# Desc     : 一键源码安装、配置并启用 Fail2ban + UFW 集成防护
# Platform : Ubuntu / Debian / CentOS                              
# Version  : 1.1                               
# Date     : 2025-11-03                           
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install Fail2ban with UFW support")" 

set -e

VERSION="1.1.0"
SRC_DIR="${HOME}/webserver/src"
INSTALL_PREFIX="/usr/local"
CONFIG_DIR="/etc/fail2ban"
SERVICE_FILE="/etc/systemd/system/fail2ban.service"

echo "=============================================="
echo " 🚀 开始安装 Fail2ban v$VERSION (源码方式 + UFW)"
echo "=============================================="

# ---------- 1. 安装依赖 ----------
echo "📦 安装依赖..."
sudo apt update -y || true
sudo apt install -y python3 python3-distutils python3-systemd iptables ufw wget tar || true

# ---------- 2. 下载源码 ----------
echo "⬇️ 下载 Fail2ban 源码包..."
cd $SRC_DIR
if [ ! -f "fail2ban-$VERSION.tar.gz" ]; then
    wget -q https://github.com/fail2ban/fail2ban/archive/refs/tags/$VERSION.tar.gz -O fail2ban-$VERSION.tar.gz
fi
tar xf fail2ban-$VERSION.tar.gz
cd fail2ban-$VERSION

# ---------- 3. 安装 ----------
echo "⚙️ 执行安装..."
sudo python3 setup.py install --prefix=$INSTALL_PREFIX

# ---------- 4. 创建配置 ----------
echo "🧱 创建配置目录..."
sudo mkdir -p $CONFIG_DIR
if [ -d "config" ]; then
    echo "📁 从源码 config/ 复制默认配置..."
    sudo cp -r config/* $CONFIG_DIR/
else
    echo "⚠️ 未找到 Fail2ban 默认配置目录，跳过复制"
fi

if [ ! -f "$CONFIG_DIR/jail.local" ]; then
    sudo cp $CONFIG_DIR/jail.conf $CONFIG_DIR/jail.local
fi

# ---------- 5. 写入基础配置 ----------
echo "🧩 写入基础配置 (UFW 模式)..."
sudo bash -c "cat > $CONFIG_DIR/jail.local" <<'EOF'
[DEFAULT]
# 封禁时间（秒）
bantime = 600
# 检测周期（秒）
findtime = 600
# 最大重试次数
maxretry = 3
# 忽略的IP
ignoreip = 127.0.0.1/8 ::1

# 使用 ufw 进行封禁
banaction = ufw
banaction_allports = ufw

[sshd]
enabled = true
port = 22000
filter = sshd
logpath = /var/log/auth.log
maxretry = 5
EOF

# ---------- 6. 创建 systemd 服务 ----------
echo "🧠 创建 systemd 服务..."
sudo bash -c "cat > $SERVICE_FILE" <<EOF
[Unit]
Description=Fail2Ban Service
After=network.target iptables.service firewalld.service ufw.service

[Service]
Type=simple
ExecStart=$INSTALL_PREFIX/bin/fail2ban-server -xf start
ExecStop=$INSTALL_PREFIX/bin/fail2ban-client stop
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# ---------- 7. 启用服务 ----------
echo "♻️ 启用并启动 fail2ban 服务..."
sudo systemctl daemon-reload
sudo systemctl enable fail2ban
sudo systemctl restart fail2ban

# ---------- 8. 验证 ----------
echo "🔍 验证 Fail2ban 状态..."
if sudo fail2ban-client ping | grep -q "pong"; then
    echo "✅ Fail2ban 已成功运行！"
else
    echo "❌ 启动失败，请检查日志：sudo journalctl -u fail2ban"
    exit 1
fi

# ---------- 9. 检查 UFW 状态 ----------
echo "🧯 检查 UFW 防火墙..."
sudo ufw status verbose || true

echo "----------------------------------------------"
echo " 🎉 Fail2ban 安装与启动完成！"
echo "📂 配置目录：$CONFIG_DIR"
echo "⚙️ 服务控制：sudo systemctl status fail2ban"
echo "🧱 封禁方式：UFW"
echo "----------------------------------------------"
