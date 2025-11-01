#!/bin/bash
################################################
# Function : Install LNMP-PHP 8.4.10  
# Desc     : 用于安装LNMP-PHP 8.4.10的脚本                             
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2025-07-14                           
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install LNMP-PHP 8.4.10")" 

set -e

# 安装依赖
echo "✅ 安装必要依赖..."
sudo apt update
sudo apt install -y build-essential libxml2-dev libssl-dev libcurl4-openssl-dev \
libjpeg-dev libpng-dev libwebp-dev libfreetype6-dev libzip-dev libonig-dev \
pkg-config wget libsqlite3-dev

echo "✅ 设置变量"

BASE_DIR=~/webserver
SRC_DIR="${BASE_DIR}/src"
PHP_VERSION=8.4.10
PHP_DIR="${BASE_DIR}/php"
INSTALL_DIR="${BASE_DIR}/php-${PHP_VERSION}"

echo "✅ 新建目录LMMP目录"
mkdir -p ${SRC_DIR}
cd ${SRC_DIR}

echo "✅ 下载新版本 php-${PHP_VERSION}.tar.gz"
if [ ! -f "${SRC_DIR}/php-${PHP_VERSION}.tar.gz" ]; then
  wget https://mirrors.sohu.com/php/php-${PHP_VERSION}.tar.gz
fi
tar -xzvf php-${PHP_VERSION}.tar.gz

cd php-${PHP_VERSION}

echo "✅ PHP 常用编译命令"
./configure \
--prefix=${INSTALL_DIR} \
--with-config-file-path=${INSTALL_DIR}/etc \
--enable-fpm \
--with-fpm-user=www \
--with-fpm-group=www \
--enable-mbstring \
--with-curl \
--with-openssl \
--enable-pcntl \
--enable-sockets \
--enable-zip \
--enable-soap \
--with-zlib \
--enable-bcmath \
--with-gettext \
--enable-exif \
--enable-opcache \
--with-mysqli \
--with-pdo-mysql \
--with-pear \
--enable-shmop \
--enable-sysvsem \
--with-gd \
--with-jpeg \
--with-webp \
--with-freetype

echo "✅ 编译 PHP..."
make -j$(nproc)
make install

echo "✅ 设置统一入口 symlink: php -> php-${PHP_VERSION}"
ln -sfn "${INSTALL_DIR}" "${PHP_DIR}"

echo "✅ 创建 PHP‑FPM 专用用户和组 www"
if ! getent group www >/dev/null; then
  sudo groupadd --system www
fi
if ! id www >/dev/null 2>&1; then
  sudo useradd --system --no-create-home --gid www --shell /usr/sbin/nologin www
fi

echo "✅ 创建 PHP-FPM 配置"
mkdir -p ${PHP_DIR}/etc ${PHP_DIR}/var/run
cp -r ${PHP_DIR}/etc/php-fpm.conf.default ${PHP_DIR}/etc/php-fpm.conf
PID_FILE="${PHP_DIR}/var/run/php-fpm.pid"
sudo sed -i "s|^; pid = run/php-fpm\.pid|pid = ${PID_FILE}|" ${PHP_DIR}/etc/php-fpm.conf

cp -r ${PHP_DIR}/etc/php-fpm.d/www.conf.default ${PHP_DIR}/etc/php-fpm.d/www.conf
PHP_POOL="${PHP_DIR}/etc/php-fpm.d/www.conf"
sudo sed -i 's/^user = .*/user = www/' "$PHP_POOL"
sudo sed -i 's/^group = .*/group = www/' "$PHP_POOL"
sudo sed -i 's|^listen = .*|listen = /run/php-fpm.sock|' "$PHP_POOL"
grep -q '^listen.owner' "$PHP_POOL" || tee -a "$PHP_POOL" >/dev/null <<EOF

listen.owner = www
listen.group = www
listen.mode = 0660
EOF

echo "✅ 安装完成: ${PHP_DIR}"

echo "✅ 创建 systemd 启动服务..."
sudo tee /etc/systemd/system/php-fpm.service >/dev/null <<EOF
[Unit]
Description=Custom PHP-FPM Service
After=network.target

[Service]
Type=forking
PIDFile=${PHP_DIR}/var/run/php-fpm.pid
ExecStart=${PHP_DIR}/sbin/php-fpm --daemonize  --fpm-config ${PHP_DIR}/etc/php-fpm.conf
ExecReload=${PHP_DIR}/sbin/php-fpm --reload  --fpm-config ${PHP_DIR}/etc/php-fpm.conf
ExecStop=${PHP_DIR}/sbin/php-fpm --terminate --fpm-config ${PHP_DIR}/etc/php-fpm.conf
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable php-fpm
sudo systemctl start php-fpm

echo "🎉 php-fpm 已启动。"