#!/bin/bash
################################################
# Function : Install ESP-IDF Development Environment (with venv)
# Desc     : 一键安装 ESP32/ESP32-S3 官方 ESP-IDF（独立Python环境）
# Platform : Ubuntu (20.04 / 22.04 / 24.04)
# Version  : 1.1
# Date     : 2025-11-29
# Author   : ncnynl
# Contact  : 1043931@qq.com
# URL      : https://ncnynl.com
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ESP-IDF Development Environment")"

set -e

IDF_PATH="$HOME/esp-idf"
IDF_PYENV="$HOME/.espressif/esp_idf_pyenv_v5.3"

echo "=== 更新系统 ==="
sudo apt update

echo "=== 安装依赖 ==="
sudo apt install -y git wget flex bison gperf python3 python3-pip python3-venv \
     cmake ninja-build ccache libffi-dev libssl-dev dfu-util \
     libusb-1.0-0 udev

echo "=== 克隆 ESP-IDF (v5.3) ==="
if [ ! -d "$IDF_PATH" ]; then
    git clone -b v5.3 --recursive https://github.com/espressif/esp-idf.git "$IDF_PATH"
else
    echo "目录 $IDF_PATH 已存在，跳过克隆。"
fi

echo "=== 安装 ESP-IDF 工具链（使用 venv） ==="
cd "$IDF_PATH"
./install.sh

echo "=== 自动设置 export.sh 环境加载（使用独立 venv） ==="
if ! grep -q "source $IDF_PATH/export.sh" ~/.bashrc; then
    echo "source $IDF_PATH/export.sh" >> ~/.bashrc
fi

echo "=== 配置串口权限 ==="
sudo usermod -a -G dialout $USER
sudo udevadm control --reload-rules
sudo udevadm trigger

echo ""
echo "===================================="
echo "  ESP-IDF + 独立 Python 环境安装完成！"
echo ""
echo "  环境位于: $IDF_PYENV"
echo ""
echo "  使用前请重新登录或执行："
echo "      source $IDF_PATH/export.sh"
echo ""
echo "  测试版本："
echo "      idf.py --version"
echo ""
echo "  示例运行："
echo "      cd $IDF_PATH/examples/get-started/hello_world"
echo "      idf.py set-target esp32"
echo "      idf.py build flash monitor"
echo "===================================="
