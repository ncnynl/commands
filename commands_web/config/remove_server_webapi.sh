#!/bin/bash

# 设置变量
SERVICE_NAME="server_webapi.service"


# 获取当前 Python 包的位置
FLASK_APP_PATH="$(dirname "$(dirname "$(realpath "$0")")")"  # 获取脚本所在目录作为 Flask 应用路径

echo "当前项目根目录"
echo $FLASK_APP_PATH

# 获取当前用户
USERNAME="$(whoami)"  # 获取当前系统用户名

# 检查是否以 root 用户运行
# if [ "$EUID" -ne 0 ]; then
#     echo "请使用 root 用户运行此脚本或使用 sudo。"
#     exit 1
# fi

SERVICE_FILE="$HOME/.config/systemd/user/$SERVICE_NAME"

if [ -f $SERVICE_FILE ]; then 

    #停止服务
    systemctl --user stop $SERVICE_NAME

    #禁用服务（防止开机自动启动
    systemctl --user disable $SERVICE_NAME

    #删除服务文件
    rm $SERVICE_FILE

    #刷新 systemd 用户守护进程
    systemctl --user daemon-reload

    echo "$SERVICE_NAME 已成功移除。"
fi 


