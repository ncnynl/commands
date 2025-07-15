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
sudo apt install libonig-dev

echo "✅ 设置变量"
INSTALL_DIR=~/webserver
PHP_VERSION=8.4.10

echo "✅ 新建目录LMMP目录"
mkdir -p ${INSTALL_DIR}


cd ${INSTALL_DIR}


echo "✅ 下载新版本 php-${PHP_VERSION}.tar.gz"
wget https://mirrors.sohu.com/php/php-${PHP_VERSION}.tar.gz
tar -xzvf php-${PHP_VERSION}.tar.gz

#ln -s php-${PHP_VERSION} php
cd php

echo "✅ PHP 常用编译命令"
./configure \
--prefix=${INSTALL_DIR}/php-${PHP_VERSION} \
--with-config-file-path=${INSTALL_DIR}/php-${PHP_VERSION}/etc \
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
--enable-sysvsem

echo "✅ 编译 PHP..."
make -j$(nproc)
make install

echo "✅ 创建 PHP‑FPM 专用用户和组 www"
if ! getent group www >/dev/null; then
  sudo groupadd --system www
fi
if ! id www >/dev/null 2>&1; then
  sudo useradd --system --no-create-home --gid www --shell /usr/sbin/nologin www
fi

echo "✅ php-fpm.conf"
cp -r ${INSTALL_DIR}/php/etc/php-fpm.conf.default ${INSTALL_DIR}/php/etc/php-fpm.conf
sudo sed -i \
  's|^; pid = run/php-fpm\.pid|pid = /home/ubuntu/webserver/php/var/run/php-fpm.pid|' \
  ${INSTALL_DIR}/php/etc/php-fpm.conf


echo "✅ 修改 PHP-FPM 池配置 (${INSTALL_DIR}/php/etc/php-fpm.d/www.conf)"
PHP_POOL="${INSTALL_DIR}/php/etc/php-fpm.d/www.conf"
sudo sed -i 's/^user = .*/user = www/' "$PHP_POOL"
sudo sed -i 's/^group = .*/group = www/' "$PHP_POOL"
sudo sed -i 's|^listen = .*|listen = /run/php-fpm.sock|' "$PHP_POOL"
grep -q '^listen.owner' "$PHP_POOL" || tee -a "$PHP_POOL" >/dev/null <<EOF

; Set socket ownership and permissions
listen.owner = ubuntu
listen.group = ubuntu
listen.mode = 0660
EOF

echo "✅ 安装完成: ${INSTALL_DIR}/nginx-${PHP_VERSION}"

echo "✅ 创建 systemd 启动服务..."
sudo tee /etc/systemd/system/php-fpm.service >/dev/null <<EOF
[Unit]
Description=Custom PHP-FPM Service
After=network.target

[Service]
Type=forking
PIDFile=${INSTALL_DIR}/php/var/run/php-fpm.pid
ExecStart=${INSTALL_DIR}/php/sbin/php-fpm --daemonize  --allow-to-run-as-root --fpm-config ${INSTALL_DIR}/php/etc/php-fpm.conf
ExecReload=${INSTALL_DIR}/php/sbin/php-fpm --reload  --allow-to-run-as-root --fpm-config ${INSTALL_DIR}/php/etc/php-fpm.conf
ExecStop=${INSTALL_DIR}/php/sbin/php-fpm --terminate --fpm-config ${INSTALL_DIR}/php/etc/php-fpm.conf
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable php-fpm
sudo systemctl start php-fpm

echo "🎉 php-fpm 已启动。"