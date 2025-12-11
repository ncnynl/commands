#!/bin/bash
################################################
# Function : Install Zenoh from Source  
# Desc     : 从源码编译安装 Zenoh（含 Router + CLI + ROS2 Bridge 插件）                    
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
echo "$(gettext "Install Zenoh from Source")"
set -e

echo "--------------------------------------------"
echo "   Zenoh 源码安装脚本启动"
echo "--------------------------------------------"

INSTALL_DIR=/usr/local
PLUGIN_DIR=/usr/local/lib/zenoh/plugins
SOURCE_DIR=$HOME/zenoh_src

mkdir -p $SOURCE_DIR
mkdir -p $PLUGIN_DIR

################################################
# 1. 安装 Rust 工具链
################################################
echo "👉 安装 Rust..."
if ! command -v cargo &> /dev/null; then
    echo "Rust 未安装，安装中..."
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    source $HOME/.cargo/env
else
    echo "Rust 已安装，跳过"
fi

rustup update

################################################
# 2. 克隆 Zenoh 源码
################################################
echo "👉 克隆 Zenoh 仓库..."
cd $SOURCE_DIR

if [ ! -d "zenoh" ]; then
    git clone https://github.com/eclipse-zenoh/zenoh.git
else
    echo "Zenoh 目录已存在，执行 git pull"
    cd zenoh
    git pull
    cd ..
fi

################################################
# 3. 编译 Zenoh 主体（Router + CLI）
################################################
echo "👉 编译 Zenoh..."
cd $SOURCE_DIR/zenoh

# 启用全部组件 router + cli + plugins
cargo build --release --all-features

echo "✔ Zenoh 编译完成"

################################################
# 4. 安装 Zenoh 可执行文件
################################################
echo "👉 安装 Zenoh 二进制文件..."

sudo cp target/release/zenohd $INSTALL_DIR/bin/
sudo cp target/release/z_* $INSTALL_DIR/bin/
sudo chmod +x $INSTALL_DIR/bin/zenohd
sudo chmod +x $INSTALL_DIR/bin/z_*

echo "✔ Zenoh Router & CLI 安装完成"

################################################
# 5. 克隆并编译 Zenoh ROS2 Bridge 插件
################################################
echo "👉 克隆 ROS2 DDS 插件..."
cd $SOURCE_DIR

if [ ! -d "zenoh-plugin-ros2dds" ]; then
    git clone https://github.com/eclipse-zenoh/zenoh-plugin-ros2dds.git
else
    echo "插件已存在，更新..."
    cd zenoh-plugin-ros2dds
    git pull
    cd ..
fi

echo "👉 编译 ROS2 Bridge 插件..."
cd $SOURCE_DIR/zenoh-plugin-ros2dds
cargo build --release

sudo cp target/release/libzenoh_plugin_ros2dds.so $PLUGIN_DIR/

echo "✔ Zenoh ROS2 插件安装完成"

################################################
# 6. 打印使用方法
################################################
echo "--------------------------------------------"
echo "  Zenoh 源码安装完成！"
echo "--------------------------------------------"
echo "运行 Zenoh Router："
echo "  zenohd"
echo ""
echo "运行 Zenoh Pub/Sub："
echo "  z_pub demo/hello \"Hello Zenoh\""
echo "  z_sub demo/hello"
echo ""
echo "启用 ROS2 Bridge："
echo "  zenohd -c platform.json"
echo ""
echo "插件位置：$PLUGIN_DIR"
echo "--------------------------------------------"

exit 0
