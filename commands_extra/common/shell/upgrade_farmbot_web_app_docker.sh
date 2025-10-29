#!/bin/bash
################################################
# Function : Upgrade FarmBot Web App in Docker
# Desc     : 用于升级 FarmBot Web App Docker 服务的脚本
# Platform : Ubuntu / WSL2 / Docker
# Version  : 1.1
# Date     : 2025-10-09
# Author   : ncnynl
# Contact  : 1043931@qq.com
# URL      : https://ncnynl.com
# License  : MIT
################################################

set -e

echo "=============================================="
echo "🚀 FarmBot Web App Docker 升级脚本"
echo "=============================================="

# === 检查环境 ===
if ! command -v docker &> /dev/null; then
  echo "❌ 未检测到 Docker，请先安装 Docker。"
  exit 1
fi

if ! command -v docker compose &> /dev/null; then
  echo "❌ 未检测到 Docker Compose，请先安装 docker-compose 插件。"
  exit 1
fi

# === 检查目录 ===
if [ ! -d "Farmbot-Web-App" ]; then
  echo "❌ 未找到 Farmbot-Web-App 目录，请先运行安装脚本。"
  exit 1
fi

cd Farmbot-Web-App

# === 关闭旧服务 ===
echo "🛑 停止旧版本容器..."
docker compose down

# === 备份数据库 ===
echo "💾 创建数据库备份..."
timestamp=$(date +%Y%m%d%H%M%S)
backup_file="dump_${timestamp}.sql"
docker compose exec db pg_dumpall -U postgres > "${backup_file}"
echo "✅ 数据库已备份到 ${backup_file}"

# === 更新代码 ===
echo "⬇️ 拉取最新版本代码..."
git fetch origin main
git pull origin main

# === 清理旧缓存与依赖 ===
echo "🧹 清理缓存与依赖..."
rm -rf .parcel-cache/ node_modules/

# === 安装依赖 ===
echo "📦 重新安装依赖..."
docker compose run web gem install bundler
docker compose run web bundle install
docker compose run web npm install

# === 检查数据库版本 ===
echo "🧩 检查数据库服务状态..."
docker compose up -d db
sleep 5
docker compose exec db pg_dumpall -V

# === 恢复数据库（可选）===
echo "⚠️ 如果希望恢复上次备份，请手动执行："
# echo "docker compose exec -T db psql -U postgres < ${backup_file}"

# === 执行数据库迁移 ===
echo "📊 执行数据库迁移..."
docker compose run web rails db:migrate

# === 验证构建 ===
echo "🧱 验证前端构建..."
docker compose run web rake assets:precompile

# === 重启服务 ===
echo "🚀 启动新版本服务..."
docker compose up -d

# === 显示版本信息 ===
echo "✅ 升级完成！"
echo "📍 当前版本: $(git rev-parse --short HEAD)"
echo "💡 访问地址: http://<你的IP地址>:3000/"
echo "📦 数据库备份文件: ${backup_file}"
echo "=============================================="
