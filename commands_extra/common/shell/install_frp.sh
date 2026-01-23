#!/usr/bin/env bash
################################################
# Function : 安装 FRP（客户端或服务端）
# Desc     : 运行脚本后可选择安装 frpc（客户端）或 frps（服务端），并创建 systemd 服务自启
# Platform : Ubuntu
# Version  : 1.3
# Date     : 2026-01-23
# Author   : ncnynl
# Contact  : 1043931@qq.com
# URL      : https://ncnynl.com
# QQ Qun   : 创客智造B群:926779095
# QQ Qun   : 创客智造C群:937347681
# QQ Qun   : 创客智造D群:562093920
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install FRP")"  

set -e

FRP_VERSION="0.53.2"
INSTALL_DIR="/usr/local/bin"
CONFIG_DIR="/etc/frp"
SERVICE_DIR="/etc/systemd/system"

# root 检查
if [ "$EUID" -ne 0 ]; then
  echo "请使用 root 或 sudo 运行"
  exit 1
fi

echo "======================================"
echo "欢迎使用 FRP 安装脚本"
echo "请选择安装模式："
echo "1) frpc 客户端"
echo "2) frps 服务端"
echo "3) 退出"
echo "======================================"

read -rp "请输入选项 [1-3]: " choice

case "$choice" in
  1) MODE="frpc" ;;
  2) MODE="frps" ;;
  3) echo "已退出安装"; exit 0 ;;
  *) echo "无效选项"; exit 1 ;;
esac

echo "===> 正在安装 ${MODE} (FRP v${FRP_VERSION})"

# 架构检测
ARCH=$(uname -m)
case "$ARCH" in
  x86_64) FRP_ARCH="amd64" ;;
  aarch64) FRP_ARCH="arm64" ;;
  armv7l|armv6l) FRP_ARCH="arm" ;;
  *) echo "不支持的架构: $ARCH"; exit 1 ;;
esac

echo "检测到架构: $FRP_ARCH"

FRP_PKG="frp_${FRP_VERSION}_linux_${FRP_ARCH}.tar.gz"
FRP_URL="https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/${FRP_PKG}"

# 下载并解压
cd /tmp
echo "下载 $FRP_URL"
curl -fLO "$FRP_URL"

tar -zxf "$FRP_PKG"
cd "frp_${FRP_VERSION}_linux_${FRP_ARCH}"

# 安装二进制
install -m 755 "$MODE" "${INSTALL_DIR}/${MODE}"

# 配置目录
mkdir -p "$CONFIG_DIR"
if [ ! -f "$CONFIG_DIR/${MODE}.toml" ]; then
  cp "${MODE}.toml" "$CONFIG_DIR/"
fi

# systemd 服务文件
SERVICE_FILE="${SERVICE_DIR}/${MODE}.service"
cat > "$SERVICE_FILE" <<EOF
[Unit]
Description=FRP ${MODE}
After=network.target

[Service]
Type=simple
ExecStart=${INSTALL_DIR}/${MODE} -c ${CONFIG_DIR}/${MODE}.toml
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable "$MODE"
systemctl restart "$MODE"

echo "======================================"
echo "FRP ${MODE} 安装完成 ✅"
echo "二进制: ${INSTALL_DIR}/${MODE}"
echo "配置文件: ${CONFIG_DIR}/${MODE}.toml"
echo "状态查看: systemctl status ${MODE}"
echo "日志查看: journalctl -u ${MODE} -f"
echo "======================================"

# 清理临时文件
cd /tmp
rm -rf "frp_${FRP_VERSION}_linux_${FRP_ARCH}" "$FRP_PKG"