#!/bin/bash
################################################
# Function : Update Hostname
# Desc     : 用于更新主机名的脚本                           
# Platform : ubuntu                                 
# Version  : 1.0                               
# Date     : 2025-01-04                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# License: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Update Hostname")"

# 检查是否以 root 用户运行脚本
if [ "$EUID" -ne 0 ]; then
  echo "请使用 root 权限运行此脚本."
  exit 1
fi

# 显示当前主机名
CURRENT_HOSTNAME=$(hostname)
echo "当前的主机名是: $CURRENT_HOSTNAME"

# 询问用户输入新主机名
echo "请输入新的主机名："
read NEW_HOSTNAME

# 检查输入是否为空
if [ -z "$NEW_HOSTNAME" ]; then
  echo "主机名不能为空！"
  exit 1
fi

# 修改 /etc/hostname 文件
echo "$NEW_HOSTNAME" > /etc/hostname

# 删除原有主机记录并保留 localhost 行
# 保证 localhost 记录不被更改，同时删除原有的主机名记录
sed -i "/127\.0\.0\.1.*$CURRENT_HOSTNAME/d" /etc/hosts

# 添加新的主机名记录到 /etc/hosts
echo "127.0.0.1   $NEW_HOSTNAME" >> /etc/hosts

# 使用 hostnamectl 设置新主机名（适用于 systemd 系统）
hostnamectl set-hostname "$NEW_HOSTNAME"

echo "主机名已更改为: $NEW_HOSTNAME"
echo "请重启以应用更改."
