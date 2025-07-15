#!/bin/bash
################################################
# Function : Install LNMP NGINX 1.20.0  
# Desc     : 用于安装LNMP-NGINX 1.20.0的脚本                             
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
echo "$(gettext "Install LNMP-NGINX 1.20.0")" 
set -e

# 安装依赖
echo "✅ 安装必要依赖..."
sudo apt update
sudo apt install -y build-essential curl wget git unzip \
libpcre3 libpcre3-dev zlib1g-dev libssl-dev \
libgd-dev libxslt1-dev libgeoip-dev libperl-dev

# 设置变量
INSTALL_DIR=~/webserver
NGINX_VERSION=1.20.0
OPENSSL_VERSION=1.1.1k
LUAJIT_VERSION=2.1-20201229
NDK_VERSION=0.3.1
LUA_MODULE_VERSION=0.10.20rc1

#新建目录LAMP目录
mkdir -p ${INSTALL_DIR}
cd ${INSTALL_DIR}


echo "✅ 下载 Nginx..."
wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
tar -xzf nginx-${NGINX_VERSION}.tar.gz
mv nginx-${NGINX_VERSION} nginx-${NGINX_VERSION}-src
mkdir nginx-${NGINX_VERSION}
ln -s nginx-${NGINX_VERSION} nginx


echo "✅ 下载 OpenSSL..."
wget https://www.openssl.org/source/old/1.1.1/openssl-${OPENSSL_VERSION}.tar.gz
tar -xzf openssl-${OPENSSL_VERSION}.tar.gz

##############begin for LuaJIT
echo "✅ 下载 ngx_devel_kit..."
wget https://github.com/vision5/ngx_devel_kit/archive/refs/tags/v${NDK_VERSION}.tar.gz
tar xf v${NDK_VERSION}.tar.gz

echo "✅ 下载 lua-nginx-module..."
wget https://github.com/openresty/lua-nginx-module/archive/refs/tags/v${LUA_MODULE_VERSION}.tar.gz
tar xf v${LUA_MODULE_VERSION}.tar.gz

echo "✅ 下载 luajit2..."
wget https://github.com/openresty/luajit2/archive/refs/tags/v${LUAJIT_VERSION}.tar.gz
tar xf v${LUAJIT_VERSION}.tar.gz
cd luajit2-${LUAJIT_VERSION}
make
sudo make install
cd ..

echo "✅ 安装lua-resty-core"
https://github.com/openresty/lua-resty-core/archive/refs/tags/v0.1.22rc1.tar.gz
tar xf v0.1.22rc1.tar.gz

echo "✅ 安装lua-resty-lrucache"
wget https://github.com/openresty/lua-resty-lrucache/archive/refs/tags/v0.11rc1.tar.gz
tar xf v0.11rc1.tar.gz

sudo mkdir -p /usr/local/share/lua/5.1
sudo cp -r lua-resty-core-0.1.22rc1/lib/*  /usr/local/share/lua/5.1/
sudo cp -r lua-resty-lrucache-0.11rc1/lib/*   /usr/local/share/lua/5.1/

export LUAJIT_LIB=/usr/local/lib
export LUAJIT_INC=/usr/local/include/luajit-2.1

####################end

echo "✅ 编译 Nginx..."
cd nginx-${NGINX_VERSION}-src

./configure \
--prefix=${INSTALL_DIR}/nginx-${NGINX_VERSION} \
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
--with-openssl=$INSTALL_DIR/openssl-${OPENSSL_VERSION} \
--with-openssl-opt=enable-tls1_3 \
--add-module=$INSTALL_DIR/ngx_devel_kit-${NDK_VERSION} \
--add-module=$INSTALL_DIR/lua-nginx-module-${LUA_MODULE_VERSION} \
--with-cc-opt="-I$LUAJIT_INC" \
--with-ld-opt="-L$LUAJIT_LIB -Wl,-rpath,$LUAJIT_LIB"

make
sudo make install

# 设置目录和文件的所有者为 nginx 用户（假设 nginx 用户为 ubuntu）
sudo chown -R ubuntu:ubuntu /home/ubuntu/webserver/nginx-${NGINX_VERSION}
sudo usermod -aG ubuntu www

echo "✅ 安装完成: ${INSTALL_DIR}/nginx-${NGINX_VERSION}"

# 添加 systemd 服务
echo "✅ 创建 systemd 启动服务..."
sudo tee /etc/systemd/system/nginx.service >/dev/null <<EOF
[Unit]
Description=Custom Nginx Server
After=network.target

[Service]
Type=forking
ExecStart=${INSTALL_DIR}/nginx/sbin/nginx
ExecReload=${INSTALL_DIR}/nginx/sbin/nginx -s reload
ExecStop=${INSTALL_DIR}/nginx/sbin/nginx -s quit
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable nginx
sudo systemctl start nginx

echo "🎉 Nginx 已启动并支持 Lua + TLS1.3，访问状态页或部署网站即可使用。"
