#!/bin/bash
################################################
# Function : Install samba  
# Desc     : 用于安装samba管理工具脚本                             
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2024-10-29                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install samba")" 

# 更新软件包列表
echo "更新软件包列表..."
sudo apt update

# 安装 Samba
echo "安装 Samba..."
sudo apt install -y samba

# 配置 Samba
echo "配置 Samba..."
CONFIG_FILE="/etc/samba/smb.conf"
SHARE_DIR="~/tool/samba/share"

# 创建共享目录
if [ ! -d "$SHARE_DIR" ]; then
    echo "创建共享目录 $SHARE_DIR ..."
    sudo mkdir -p "$SHARE_DIR"
    sudo chmod 777 "$SHARE_DIR"
fi

# 添加共享配置
if ! grep -q "\[share\]" "$CONFIG_FILE"; then
    echo "添加共享配置..."
    {
        echo "[share]"
        echo "   path = $SHARE_DIR"
        echo "   browsable = yes"
        echo "   writable = yes"
        echo "   guest ok = yes"
        echo "   read only = no"
    } | sudo tee -a "$CONFIG_FILE" > /dev/null
else
    echo "共享配置已存在，跳过添加。"
fi

# 重新启动 Samba 服务
echo "重新启动 Samba 服务..."
sudo systemctl restart smbd

# 验证 Samba 服务状态
echo "检查 Samba 服务状态..."
sudo systemctl status smbd

# 配置防火墙
echo "配置防火墙..."
sudo ufw allow Samba

echo "Samba 安装和配置完成！共享目录位于: $SHARE_DIR"
