#!/bin/bash
################################################
# Function : Install FarmBot Web App in Docker
# Desc     : 用于 Docker 安装 FarmBot Web App 的自动化脚本
# Platform : Ubuntu / WSL2 / Docker
# Version  : 1.1
# Date     : 2025-10-09
# Author   : ncnynl
# Contact  : 1043931@qq.com
# URL      : https://ncnynl.com
# License  : MIT
################################################
# https://github.com/FarmBot/Farmbot-Web-App/blob/staging/local_setup_instructions.sh

set -e
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands
echo "$(gettext "Install FarmBot Web App in Docker")"

# === 环境检查 ===
if ! command -v docker &> /dev/null; then
  echo "❌ 未检测到 Docker，请先安装 Docker."
  exit 1
fi

if ! command -v docker compose &> /dev/null; then
  echo "❌ 未检测到 Docker Compose，请先安装 docker-compose 插件."
  exit 1
fi

# === 克隆代码仓库 ===

cd ~/docker/

if [ ! -d "Farmbot-Web-App" ]; then
  echo "📦 正在克隆 FarmBot Web App 仓库..."
  git clone https://github.com/FarmBot/Farmbot-Web-App --depth=5 --branch=main
else
  echo "✅ 目录已存在，跳过克隆。"
fi

cd Farmbot-Web-App

# === 环境配置 ===
if [ ! -f ".env" ]; then
  echo "⚙️ 复制环境配置文件 example.env -> .env"
  cp example.env .env
  echo "👉 请根据需要编辑 .env 文件（API_HOST, MQTT_HOST 等）"
  nano .env
else
  echo "✅ 已存在 .env 文件，跳过。"
fi

# === 安装依赖 ===
echo "🔧 安装 Ruby 和 JS 依赖..."
docker compose run web gem install bundler
docker compose run web bundle install
docker compose run web npm install

# === 初始化数据库 ===
echo "🧩 初始化数据库..."
docker compose run web bundle exec rails db:create db:migrate

# === 生成密钥文件 ===
if [ ! -d "config/keys" ]; then
  echo "🔐 生成加密密钥..."
  docker compose run web rake keys:generate
fi

# === 启动服务 ===
echo "🚀 启动 FarmBot Web App..."
docker compose up

# === 可选测试步骤 ===
# echo "✅ 运行测试 (可选)"
# docker compose run -e RAILS_ENV=test web bundle exec rails db:setup
# docker compose run -e RAILS_ENV=test web rspec spec
# docker compose run web npm run test

# === 提示 ===
echo ""
echo "🎉 FarmBot Web App 已启动！"
echo "👉 在浏览器访问: http://<你的IP地址>:3000/"
echo "如需停止，请运行: docker compose down"
