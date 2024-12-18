#!/bin/bash


# 设置变量
SERVICE_NAME="server_webapi.service"

# SERVICE_FILE="/etc/systemd/system/$SERVICE_NAME"
if [ ! -d $HOME/.config/systemd/user ]; then 
    mkdir -p $HOME/.config/systemd/user
fi 

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

#如果存在，则删除之前的版本你
SERVICE_FILE="$HOME/.config/systemd/user/$SERVICE_NAME"

if [ -f $SERVICE_FILE ]; then 
    echo "$SERVICE_NAME已经存在,如果要重建，请先删除!"
    exit 1
fi


# 创建 systemd 服务文件
echo "[Unit]
Description=Walking Flutter API Flask Application
After=network.target graphical.target

[Service]
Environment=DISPLAY=:0
Type=simple
WorkingDirectory=$FLASK_APP_PATH
ExecStart=/bin/bash -c 'source ~/.bashrc && /usr/bin/python3 $FLASK_APP_PATH/app.py'
Restart=always

[Install]
WantedBy=default.target" > $SERVICE_NAME

# 确保文件写入成功
if [ $? -ne 0 ]; then
    echo "无法写入服务文件: $SERVICE_NAME"
    exit 1
fi

#移动到新目录
mv $SERVICE_NAME $HOME/.config/systemd/user/



if [ -f $SERVICE_FILE ]; then 

    # 重新加载 systemd，以便识别新服务
    systemctl --user daemon-reload

    # 启用服务，使其在启动时自动运行
    systemctl --user enable $SERVICE_NAME

    # 启动服务
    systemctl --user start $SERVICE_NAME

    # 显示服务状态
    systemctl --user status $SERVICE_NAME

    #启用用户级别的 systemd
    loginctl enable-linger $USERNAME

    #首次安装生成数据库，并导入默认数据
    cd $FLASK_APP_PATH

    echo "server_webapi.service 已成功创建并启动。"
else
    echo "server_webapi.service 创建失败。"   
fi 

#查看日志
# journalctl --user -u server_webapi.service
# journalctl --user -u server_webapi.service -f
