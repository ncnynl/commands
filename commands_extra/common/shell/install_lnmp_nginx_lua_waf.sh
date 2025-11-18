#!/bin/bash
################################################
# Function : Install LNMP NGINX ngx_lua_waf 
# Desc     : 用于安装LNMP-NGINX ngx_lua_waf的脚本                             
# Platform : ubuntu                                 
# Version  : 1.0                               
# Date     : 2025-11-03                         
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install LNMP-NGINX ngx_lua_waf")" 
set -e

NGINX_CONF_DIR=${HOME}/webserver/nginx/conf
NGINX_LUA_LIB_DIR="${HOME}/webserver/nginx/resty/lib"
WAF_URL="https://github.com/whsir/ngx_lua_waf/archive/refs/tags/v1.0.3.tar.gz"
WAF_DIR="$NGINX_LUA_LIB_DIR/waf"

echo "🚀 开始安装 ngx_lua_waf ..."

# 1. 下载并解压 WAF
cd /tmp
echo "📦 下载 ngx_lua_waf..."
[ -f /tmp/v1.0.3.tar.gz ] || wget -q $WAF_URL -O v1.0.3.tar.gz
tar xf v1.0.3.tar.gz

# 2. 拷贝到指定目录
echo "📁 拷贝 waf 到 $WAF_DIR"
mkdir -p "$WAF_DIR"
cp -r ngx_lua_waf-1.0.3/* "$WAF_DIR"/

# 3. 修改 nginx.conf
CONF_FILE="$NGINX_CONF_DIR/nginx.conf"

# 检查 http 块是否存在
if grep -q "http {" "$CONF_FILE"; then
    echo "🧩 正在修改 nginx.conf ..."
    
    # 若未添加过，则插入 waf 配置
    if ! grep -q "init_by_lua_file" "$CONF_FILE"; then
        sudo sed -i '/http {/a \
    lua_package_path "'"$NGINX_LUA_LIB_DIR"'/?.lua;'"$WAF_DIR"'/?.lua;";\
    lua_shared_dict limit 10m;\
    init_by_lua_file  '"$WAF_DIR"'/init.lua;\
    access_by_lua_file '"$WAF_DIR"'/waf.lua;' "$CONF_FILE"
        echo "✅ 已成功在 nginx.conf 中添加 waf 支持"
    else
        echo "⚠️ nginx.conf 已存在 waf 配置，跳过添加"
    fi
else
    echo "❌ 未找到 http { 块，请手动检查 nginx.conf 文件"
    exit 1
fi

# 4. 测试并重启 nginx
echo "🔍 检查 nginx 配置语法 ..."
sudo ${HOME}/webserver/nginx/sbin/nginx -t

if [ $? -eq 0 ]; then
    echo "♻️ 重启 nginx ..."
    sudo ${HOME}/webserver/nginx/sbin/nginx -s reload
    echo "🎉 ngx_lua_waf 安装完成！"
else
    echo "❌ nginx 配置错误，请检查上方输出"
fi
