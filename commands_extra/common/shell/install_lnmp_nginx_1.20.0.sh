#!/bin/bash
################################################
# Function : Install LNMP NGINX 1.20.0  
# Desc     : 用于安装LNMP-NGINX 1.20.0的脚本                             
# Platform : ubuntu                                 
# Version  : 1.1                               
# Date     : 2025-10-29                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install LNMP-NGINX 1.20.0")" 
set -e

# 安装依赖
echo "✅ 安装必要依赖..."
sudo apt update
sudo apt install -y build-essential curl wget git unzip \
libpcre3 libpcre3-dev zlib1g-dev libssl-dev \
libgd-dev libxslt1-dev libgeoip-dev libperl-dev

# 设置变量
BASE_DIR=~/webserver
SRC_DIR="${BASE_DIR}/src"
NGINX_VERSION=1.20.0
OPENSSL_VERSION=1.1.1k
LUAJIT_VERSION=2.1-20201229
NDK_VERSION=0.3.1
LUA_MODULE_VERSION=0.10.20rc1
NGINX_DIR="${BASE_DIR}/nginx"
INSTALL_DIR="${BASE_DIR}/nginx-${NGINX_VERSION}"

# 新建目录
mkdir -p ${SRC_DIR}
cd ${SRC_DIR}

# 下载源码
echo "✅ 下载 nginx-${NGINX_VERSION}.tar.gz"
[ -f nginx-${NGINX_VERSION}.tar.gz ] || wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
tar -xzf nginx-${NGINX_VERSION}.tar.gz

echo "✅ 下载 OpenSSL..."
[ -f openssl-${OPENSSL_VERSION}.tar.gz ] || wget https://www.openssl.org/source/old/1.1.1/openssl-${OPENSSL_VERSION}.tar.gz
tar -xzf openssl-${OPENSSL_VERSION}.tar.gz

echo "✅ 下载 ngx_devel_kit..."
[ -f v${NDK_VERSION}.tar.gz ] || wget https://github.com/vision5/ngx_devel_kit/archive/refs/tags/v${NDK_VERSION}.tar.gz
tar xf v${NDK_VERSION}.tar.gz

echo "✅ 下载 lua-nginx-module..."
[ -f v${LUA_MODULE_VERSION}.tar.gz ] || wget https://github.com/openresty/lua-nginx-module/archive/refs/tags/v${LUA_MODULE_VERSION}.tar.gz
tar xf v${LUA_MODULE_VERSION}.tar.gz

echo "✅ 下载 luajit2..."
[ -f v${LUAJIT_VERSION}.tar.gz ] || wget https://github.com/openresty/luajit2/archive/refs/tags/v${LUAJIT_VERSION}.tar.gz
tar xf v${LUAJIT_VERSION}.tar.gz
cd luajit2-${LUAJIT_VERSION}
make && sudo make install
cd ..

echo "✅ 安装 lua-resty-core"
[ -f v0.1.22rc1.tar.gz ] || wget https://github.com/openresty/lua-resty-core/archive/refs/tags/v0.1.22rc1.tar.gz
tar xf v0.1.22rc1.tar.gz

echo "✅ 安装 lua-resty-lrucache"
[ -f v0.11rc1.tar.gz ] || wget https://github.com/openresty/lua-resty-lrucache/archive/refs/tags/v0.11rc1.tar.gz
tar xf v0.11rc1.tar.gz

sudo mkdir -p /usr/local/share/lua/5.1
sudo cp -r lua-resty-core-0.1.22rc1/lib/*  /usr/local/share/lua/5.1/
sudo cp -r lua-resty-lrucache-0.11rc1/lib/*   /usr/local/share/lua/5.1/

export LUAJIT_LIB=/usr/local/lib
export LUAJIT_INC=/usr/local/include/luajit-2.1
export PATH=/usr/local/bin:$PATH

echo "✅ 编译 Nginx..."
cd ${SRC_DIR}/nginx-${NGINX_VERSION}

./configure \
--prefix=${INSTALL_DIR} \
--user=www \
--group=www \
--with-http_stub_status_module \
--with-http_ssl_module \
--with-http_realip_module \
--with-http_image_filter_module \
--with-http_gzip_static_module \
--with-http_flv_module \
--with-pcre \
--with-stream \
--with-openssl=${SRC_DIR}/openssl-${OPENSSL_VERSION} \
--with-openssl-opt=enable-tls1_3 \
--add-module=${SRC_DIR}/ngx_devel_kit-${NDK_VERSION} \
--add-module=${SRC_DIR}/lua-nginx-module-${LUA_MODULE_VERSION} \
--with-cc-opt="-I${LUAJIT_INC}" \
--with-ld-opt="-L${LUAJIT_LIB} -Wl,-rpath,${LUAJIT_LIB}"

make -j$(nproc)
sudo make install

echo "✅ 设置统一入口 symlink: nginx -> nginx-${NGINX_VERSION}"
ln -sfn "${INSTALL_DIR}" "${NGINX_DIR}"

sudo chown -R $(whoami):$(whoami) ${NGINX_DIR}
sudo chown -R $(whoami):$(whoami) ${INSTALL_DIR}
sudo usermod -aG ubuntu www

echo "✅ 创建 systemd 启动服务..."
sudo tee /etc/systemd/system/nginx.service >/dev/null <<EOF
[Unit]
Description=Custom Nginx Server
After=network.target

[Service]
Type=forking
PIDFile=${NGINX_DIR}/logs/nginx.pid
ExecStart=${NGINX_DIR}/sbin/nginx
ExecReload=${NGINX_DIR}/sbin/nginx -s reload
ExecStop=${NGINX_DIR}/sbin/nginx -s quit
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable nginx
sudo systemctl start nginx

echo "🎉 Nginx 已启动并支持 Lua + TLS1.3，访问状态页或部署网站即可使用。"
