#!/bin/bash
################################################
# Function : Install dnsmasq
# Desc     : 用于安装dnsmasq的脚本                             
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2025-07-15                          
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install dnsmasq")" 


echo "✅ 配置变量"
LOCAL_IP=$(ip route get 1.1.1.1 | awk '{print $7}')

echo "✅ 安装dnsmasq"
sudo apt update
sudo apt install dnsmasq -y

echo "✅ 配置dnsmasq"
sudo tee /etc/dnsmasq.conf>/dev/null <<EOF
# 启用日志
log-queries
log-facility=/var/log/dnsmasq.log

# 缓存大小
cache-size=1000

# 指定本地解析的域名规则
address=/nc.lan/${LOCAL_IP}
address=/azt.lan/${LOCAL_IP}

# 监听接口和地址
listen-address=127.0.0.1,${LOCAL_IP}

# 设置外部DNS转发 
server=8.8.8.8
server=1.1.1.1
EOF

echo "🔄 关闭冲突 服务"
sudo systemctl disable --now systemd-resolved
sudo rm -f /etc/resolv.conf
echo "nameserver ${LOCAL_IP}" | sudo tee  /etc/resolv.conf
echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolv.conf


echo "🔄 重启 dnsmasq 服务"
sudo systemctl restart dnsmasq
sudo systemctl enable dnsmasq
