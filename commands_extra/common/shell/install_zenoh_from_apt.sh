#!/bin/bash
################################################
# Function : Install Zenoh from apt (Router + CLI + ROS2 Plugin)
# Desc     : 一键安装 Zenoh（含 Router、CLI 工具、ROS2 Bridge 插件）
# Platform : Ubuntu / Debian                                
# Version  : 1.0                                
# Date     : 2025-12-07                           
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL      : https://ncnynl.com                                   
# License  : MIT                                 
# QQ Qun   : 创客智造B群:926779095
# QQ Qun   : 创客智造C群:937347681
# QQ Qun   : 创客智造D群:562093920
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install Zenoh from apt")"
set -e

echo "==== Step 1: 添加 Zenoh 公共密钥 ===="
sudo mkdir -p /etc/apt/keyrings
curl -L https://download.eclipse.org/zenoh/debian-repo/zenoh-public-key \
    | sudo gpg --dearmor --yes --output /etc/apt/keyrings/zenoh-public-key.gpg

echo "==== Step 2: 添加 Zenoh 软件源 ===="
echo "deb [signed-by=/etc/apt/keyrings/zenoh-public-key.gpg] https://download.eclipse.org/zenoh/debian-repo/ /" \
    | sudo tee /etc/apt/sources.list.d/zenoh.list > /dev/null

echo "==== Step 3: 更新 apt ===="
sudo apt update

echo "==== Step 4: 安装 Zenoh ===="
sudo apt install -y zenoh

echo "==== Step 5: 安装 ROS2 ↔ Zenoh 桥接插件 ===="
sudo apt install -y zenoh-plugin-ros2dds
sudo apt install -y zenoh-bridge-ros2dds

echo "==== Step 6: 显示安装的插件版本 ===="
zenohd -l | grep ros2dds || echo "WARNING: ros2dds plugin not found in search path"

echo "==== 完成！===="
echo "你现在可以运行："
echo "  zenohd -c ~/.config/zenoh/ros2-bridge.json5"
echo "或直接："
echo "  zenohd --plugin ros2dds"
