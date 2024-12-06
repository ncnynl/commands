
#已经创建自动脚本
- 创建一个独立的load_ws.sh文件，需要加载ros2环境和工作空间

如：

```
source /opt/ros/humble/setup.bash
source ~/ros2_walking_ws/install/local_setup.bash
source ~/ros2_common_ws/install/local_setup.bash
source ~/ros2_algorithm_ws/install/local_setup.bash
```


- 生成服务脚本：install_walking_flutter_api.sh
- 删除服务脚本：remove_walking_flutter_api.sh


#大致流程

1. 创建一个服务文件
在 /etc/systemd/system/ 目录下创建一个新的服务文件。例如，命名为 walking_flutter_api.service。

bash
复制代码
sudo nano /etc/systemd/system/walking_flutter_api.service
2. 服务文件内容
在打开的编辑器中，输入以下内容：

```
[Unit]
Description=Walking Flutter API Flask Application
After=network.target

[Service]
WorkingDirectory=/home/ubuntu/tools/flutter/walking_flutter/api
ExecStart=/bin/bash -c 'source /home/ubuntu/load_ws.sh && /usr/bin/python3 /home/ubuntu/tools/flutter/walking_flutter/api/app.py'
Restart=always

[Install]
WantedBy=default.target
```

3. 修改服务文件中的内容
User: 将 YOUR_USERNAME 替换为你的用户名。
WorkingDirectory: 将 /path/to/your/flask/app 替换为你 Flask 应用的实际路径。
ExecStart: 确保指定正确的 Python 路径和 Flask 应用的脚本路径。
4. 保存并退出
按 CTRL + O 保存文件，按 CTRL + X 退出编辑器。

5. 启用和启动服务
运行以下命令以启用并启动服务：

bash
复制代码
# 重新加载 systemd 以识别新的服务文件
sudo systemctl daemon-reload

# 启用服务，使其在启动时自动运行
sudo systemctl enable walking_flutter_api.service

# 启动服务
sudo systemctl start walking_flutter_api.service
6. 检查服务状态
你可以使用以下命令检查服务的状态，以确认它正在运行：

bash
复制代码
sudo systemctl status walking_flutter_api.service
7. 访问 Flask 应用
如果你的 Flask 应用绑定在所有 IP 地址上（0.0.0.0），你可以在浏览器中访问：

arduino
复制代码
http://<your_ip_address>:5050
将 <your_ip_address> 替换为你的 Ubuntu 主机的实际 IP 地址