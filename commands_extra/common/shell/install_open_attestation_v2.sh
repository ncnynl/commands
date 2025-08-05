#!/bin/bash
################################################################
# Function : install_open_attestation_v2 
# Desc     : 安装open-attestation source version                      
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2025-08-02                          
# Author   : ncnynl                             
# Contact  : 1043931@qq.com     
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.                            
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun：创客智造B群:926779095、C群:937347681、D群:562093920                               
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "install_open_attestation_v2")"

# 设置 Node.js 版本
NODE_VERSION="18"

# 安装 n 管理器（如果未安装）
if ! command -v n &> /dev/null; then
  echo "Installing Node version manager 'n'..."
  sudo npm install -g n
fi

# 安装 Node.js
echo "Installing Node.js v$NODE_VERSION..."
sudo n $NODE_VERSION

# 检查 Node 和 npm 版本
echo "Node.js version: $(node -v)"
echo "npm version: $(npm -v)"

# 安装 yarn（可选）
if ! command -v yarn &> /dev/null; then
  echo "Installing Yarn..."
  npm install -g yarn
fi
if [ !-d ~/tools ];then 
  mkdir ~/tools
fi 

cd ~/tools

# 克隆 open-attestation monorepo（推荐方式）
echo "Cloning open-attestation..."
git clone https://github.com/Open-Attestation/open-attestation.git
cd open-attestation

# 安装依赖
echo "Installing dependencies..."
yarn install

# 构建 CLI 工具
echo "Building CLI..."
yarn build

# 在 packages/cli 目录中使用
cd packages/cli

# 链接到全局命令
echo "Linking CLI to global..."
yarn link

# 测试安装
echo "Testing installation..."
oa --version

echo "Open-Attestation CLI 安装完成。可以使用 oa 命令。"
