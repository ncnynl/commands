#!/bin/bash
################################################################
# Function : install_opencerts_website 
# Desc     : 安装opencerts-website source version                      
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
echo "$(gettext "install_opencerts_website")"

echo "🚀 开始安装 OpenCerts 网站前端..."

# 1. 创建工具目录
TOOLS_DIR=~/tools
if [ ! -d "$TOOLS_DIR" ]; then 
  echo "📁 创建目录：$TOOLS_DIR"
  mkdir -p "$TOOLS_DIR"
fi 

cd "$TOOLS_DIR"

# 2. 克隆 opencerts-website 仓库
REPO_DIR="opencerts-website"
if [ ! -d "$REPO_DIR" ]; then
  echo "📥 克隆 opencerts-website 源码..."
  git clone https://github.com/OpenCerts/opencerts-website.git
else
  echo "✅ 已存在目录 $REPO_DIR，跳过克隆。"
fi

cd "$REPO_DIR"

# 3. 安装依赖
echo "📦 安装依赖中（可能需要几分钟）..."
npm install

# 4. 启动本地开发服务器
echo "🚀 启动开发服务器..."
npm run dev

echo "✅ 安装完成！你现在可以访问：http://localhost:3000"
echo "📄 请在浏览器中打开以上地址，进行前端验证测试。"

