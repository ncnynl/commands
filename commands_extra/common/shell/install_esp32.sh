#!/bin/bash
################################################
# Function : Install ESP-IDF Development Environment
# Desc     : 一键安装 ESP32/ESP32-S3 官方 ESP-IDF 开发环境                  
# Platform : Ubuntu (20.04 / 22.04 / 24.04)
# Version  : 1.0
# Date     : 2025-11-29
# Author   : ncnynl
# Contact  : 1043931@qq.com
# URL      : https://ncnynl.com
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ESP-IDF Development Environment")"

set -e

echo "=== 更新系统 ==="
sudo apt update

echo "=== 安装依赖 ==="
sudo apt install -y git wget flex bison gperf python3 python3-pip python3-venv \
     cmake ninja-build ccache libffi-dev libssl-dev dfu-util \
     libusb-1.0-0 udev

echo "=== 克隆 ESP-IDF (v5.2) ==="
if [ ! -d "$HOME/esp-idf" ]; then
    git clone -b v5.2 --recursive https://github.com/espressif/esp-idf.git ~/esp-idf
else
    echo "目录 ~/esp-idf 已存在，跳过克隆。"
fi

echo "=== 安装工具链 ==="
cd ~/esp-idf
./install.sh all

echo "=== 设置自动加载环境变量 ==="
if ! grep -q "source ~/esp-idf/export.sh" ~/.bashrc; then
    echo 'source ~/esp-idf/export.sh' >> ~/.bashrc
fi

echo "=== 配置串口权限 ==="
sudo usermod -a -G dialout $USER
sudo udevadm control --reload-rules
sudo udevadm trigger

echo ""
echo "===================================="
echo "  ESP-IDF 安装完成！"
echo "  请重新登录当前用户以生效权限。"
echo ""
echo "  激活环境："
echo "      source ~/esp-idf/export.sh"
echo ""
echo "  测试版本："
echo "      idf.py --version"
echo ""
echo "  示例运行："
echo "      cd ~/esp-idf/examples/get-started/hello_world"
echo "      idf.py set-target esp32"
echo "      idf.py build flash monitor"
echo "===================================="
