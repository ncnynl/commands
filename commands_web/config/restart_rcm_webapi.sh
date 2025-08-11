#!/bin/bash

# 设置变量
SERVICE_NAME="rcm_webapi.service"


# 获取当前 Python 包的位置
FLASK_APP_PATH="$(dirname "$(dirname "$(realpath "$0")")")"  # 获取脚本所在目录作为 Flask 应用路径


#如果存在，则删除之前的版本你
SERVICE_FILE="$HOME/.config/systemd/user/$SERVICE_NAME"

if [ -f $SERVICE_FILE ]; then 

    # 显示服务状态
    systemctl --user stop $SERVICE_NAME

    sleep 5  # 停止后等待 5 秒

    systemctl --user start $SERVICE_NAME

    echo "rcm_webapi.service 已经重启"
else
    echo "rcm_webapi.service 不存在"   
fi 
