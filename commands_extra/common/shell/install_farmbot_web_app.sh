#!/bin/bash
################################################
# Function : Install_farmbot_web_app  
# Desc     : 用于安装farmbot_web_app的脚本                           
# Platform : WSL2 / ubuntu                                
# Version  : 1.0                               
# Date     : 2025-08-11                             
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install_farmbot_web_app ")"

set -e
echo "=== FarmBot-Web-App 全自动安装脚本 (Ubuntu 22.04) ==="

### 0. 基础依赖
sudo apt update
sudo apt install -y curl wget git vim build-essential gpg lsb-release apt-transport-https ca-certificates software-properties-common unzip

### 1. 安装 Redis
echo "=== 安装 Redis ==="
sudo apt install -y redis-server
sudo systemctl enable redis
sudo systemctl start redis
redis-cli ping

### 2. 安装 PostgreSQL
echo "=== 安装 PostgreSQL ==="
sudo apt install -y postgresql postgresql-contrib
sudo systemctl enable postgresql
sudo systemctl start postgresql
# 添加 hosts 别名
if ! grep -q "127.0.0.1 db" /etc/hosts; then
  echo "127.0.0.1 db" | sudo tee -a /etc/hosts
fi

# 修改 postgres 密码
sudo -i -u postgres psql -c "ALTER USER postgres PASSWORD 'postgres123qwe';"

### 3. 安装 RVM + Ruby 3.1.6
echo "=== 安装 RVM 和 Ruby 3.1.6 ==="
sudo apt install -y libssl-dev libreadline-dev zlib1g-dev
\curl -sSL https://rvm.io/mpapis.asc | gpg --import -
\curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
\curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 3.1.6
rvm use 3.1.6 --default
ruby -v

### 4. 安装 Erlang & RabbitMQ
echo "=== 安装 Erlang 和 RabbitMQ ==="
sudo apt install -y erlang
sudo apt install -y rabbitmq-server
sudo systemctl enable rabbitmq-server
sudo systemctl start rabbitmq-server

# 启用 RabbitMQ 插件
sudo rabbitmq-plugins enable --offline \
  rabbitmq_auth_backend_http \
  rabbitmq_management \
  rabbitmq_mqtt \
  rabbitmq_auth_backend_cache \
  rabbitmq_web_mqtt

# 创建管理员账户
sudo rabbitmqctl add_user admin admin123 || true
sudo rabbitmqctl set_user_tags admin administrator
sudo rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"

# 修改 MQTT Web 端口
sudo tee /etc/rabbitmq/rabbitmq.conf >/dev/null <<EOF
web_mqtt.tcp.port = 3002
auth_backends.1                 = cache
auth_cache.cache_ttl            = 600000
auth_cache.cached_backend       = http
auth_http.http_method           = post
auth_http.resource_path         = http://192.168.0.199:3000/api/rmq/resource
auth_http.topic_path            = http://192.168.0.199:3000/api/rmq/topic
auth_http.user_path             = http://192.168.0.199:3000/api/rmq/user
auth_http.vhost_path            = http://192.168.0.199:3000/api/rmq/vhost
default_user                    = admin
default_user_tags.administrator = true
default_user_tags.management    = true
default_pass                    = admin123
mqtt.allow_anonymous            = false
EOF
sudo systemctl restart rabbitmq-server

### 5. 安装 Node 20.14.0 / npm 10.x / parcel
echo "=== 安装 Node.js 20.14.0 / npm 10 / parcel ==="
wget https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh -O /tmp/nvm-install.sh
bash /tmp/nvm-install.sh
source ~/.bashrc
nvm install 20.14.0
npm install -g npm@10
npm install -g parcel@next

### 6. 安装 FarmBot-Web-App
echo "=== 克隆 FarmBot-Web-App ==="
cd ~
git clone https://github.com/FarmBot/Farmbot-Web-App --depth=5 --branch=main
cd Farmbot-Web-App

# 复制环境变量模板
cp example.env .env

# 安装 bundler
gem install bundler
bundle install

# 安装 JS 依赖
npm install

# 创建数据库
bundle exec rails db:create db:migrate

# 生成密钥
chmod 777 -R docker_configs docker_volumes
rake keys:generate

# 预编译前端资源
rake assets:precompile

echo "=== 安装完成！ ==="
echo "启动命令示例："
echo "1. Web: bundle exec passenger start"
echo "2. Parcel: bundle exec rake api:serve_assets"
echo "3. TypeScript: node_modules/typescript/bin/tsc -w --noEmit"
echo "4. Delayed Job: bundle exec rake jobs:work"
echo "5. Log Digests: bundle exec rake api:log_digest"
echo "6. Rabbit Jobs: bundle exec rails r lib/rabbit_workers.rb"

