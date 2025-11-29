#!/bin/bash
################################################
# Function : Install mjpg_streamer       
# Desc     : 安装 mjpg-streamer（USB 摄像头变网络摄像头）                        
# Platform : ubuntu                                 
# Version  : 1.1                               
# Date     : 2025-11-18                             
# Author   : ncnynl                             
# Contact  : 1043931@qq.com
# URL: https://ncnynl.com                                  
################################################

export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install mjpg_streamer")"

set -e

echo "=== 更新系统 ==="
sudo apt update -y

echo "=== 安装依赖 ==="
sudo apt install -y git cmake build-essential pkg-config \
    libjpeg-dev imagemagick libv4l-dev

echo "=== 下载 mjpg-streamer ==="
mkdir -p ~/tools
cd ~/tools

if [ -d mjpg-streamer ]; then
    echo "已有 mjpg-streamer，删除重新安装……"
    rm -rf mjpg-streamer
fi

git clone https://github.com/jacksonliam/mjpg-streamer.git

echo "=== 编译 mjpg-streamer ==="
cd mjpg-streamer/mjpg-streamer-experimental
make
sudo make install

WWW_DIR="$HOME/tools/mjpg-streamer/mjpg-streamer-experimental/www"

echo "=== 检查 www 目录 ==="
if [ ! -d "$WWW_DIR" ]; then
    echo "❌ 未找到 www 目录：$WWW_DIR"
    echo "安装失败，请检查仓库是否正常拉取"
    exit 1
fi

echo "=== 安装完成 ==="
echo
echo "你可以使用下面的命令启动 USB 摄像头："
echo
echo "mjpg_streamer -i \"input_uvc.so -d /dev/video0 -r 640x480 -f 30 -y\" \\"
echo "              -o \"output_http.so -w $WWW_DIR -p 8080\""
echo
echo "访问流媒体：  http://你的IP:8080/?action=stream"
echo "访问网页界面：http://你的IP:8080/  (会显示 index.html)"
echo
echo "=== 完成 ==="
