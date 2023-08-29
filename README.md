![logo](commands.png)

#### 介绍

- ROS命令管理器，全称ROS Command Manager,简称RCM
- RCM是一款简化ROS环境配置，ROS包安装，配置和启动，从而有效提高ROS学习和使用效率的工具
- RCM能支持ubuntu20.04或以上的ubuntu系统
- RCM能支持ROS1 noetic版本的rosrun / roslaunch命令运行
- RCM能支持ROS2 galactic以上版本的ros2 run / ros2 launch命令运行
- RCM能支持ubuntu系统命令的运行
- RCM能支持APT包搜索，安装
- RCM能支持自定义安装，配置，下载，启动脚本
- RCM能支持添加ROS下载资源
- RCM能支持分享自定义脚本库
- RCM的代码开源，支持二次开发定制


- 界面：

![rcm](images/main.png)



 #### 使用说明参考

开发灵感： 

- https://www.ncnynl.com/archives/202206/5316.html

安装说明: 

- https://www.ncnynl.com/archives/202206/5317.html

使用说明: 

- https://www.ncnynl.com/archives/202206/5320.html 

命令集目录说明: 

 - https://www.ncnynl.com/archives/202206/5321.html
 - https://www.ncnynl.com/archives/202206/5323.html
 - https://www.ncnynl.com/archives/202206/5324.html


#### 软件架构

```
ubuntu 20.04 +
ros2 galactic+
ros1 noetic
python3.8 
pyqt5
```



#### 在线安装教程

 - 一键安装桌面版
 - 方法一：

```
curl http://file.ncnynl.com/rcm.sh | bash -
```

- 方法二：

```
curl https://gitee.com/ncnynl/commands/raw/master/online.sh | bash -
```
 - 方法三：

```
rm online.sh ; wget https://gitee.com/ncnynl/commands/raw/master/online.sh ; sudo chmod +x ./online.sh; ./online.sh
```

 - 新开终端,输入commands

```
commands
```

 - 一键安装命令行版
 - 方法一：

```
curl http://file.ncnynl.com/rcms.sh | bash -
```
 - 方法二： 

 ```
curl https://gitee.com/ncnynl/commands/raw/master/online_shell.sh | bash -
```

- 方法三：

```
rm online_shell.sh ; wget https://gitee.com/ncnynl/commands/raw/master/online_shell.sh ; sudo chmod +x ./online_shell.sh; ./online_shell.sh
```

 - 新开终端,输入cs

```
cs
```


#### 编译源码

```
cd ~/tools/commands/commands_src
```
- 编译

```
./build
```

- 文件生成在dist，可以直接执行

```
./dist/commands
```

#### 本地编译源码并进行安装

```
cd ~/tools/commands/
```

- 运行

```
./install.sh
```

#### 编辑脚本后独立安装commans_exra目录下脚本

- 已整合为命令行版本，可以单独使用

```
cd ~/tools/commands/
```

- 运行

```
./install_extra.sh
```

#### How to add scripts to this repo
#### 共享脚本代码
 
- 1. fork repo / 克隆代码分支仓库
- 2. add your scripts / 增加代码到自己的分支仓库
- 3. submit the scripts to your repo / 提交代码到自己的分支仓库
- 4. pull request to this repo / 推送变化代码到主仓库
- 5. we will check your scripts / 审核相关代码
- 6. all ok , merge to this repo / 合并到主仓库


#### 配置说明


 - 对于系统命令,如ls top ps等可以直接使用
 - 对于ros1或ros2命令, 需要添加ros1或ros2的路径到当前用户的~/.bashrc里
 - 添加ros1 路径，执行命令:

```
cs -s init_ros1
```
 - under ros_easy folder , type the ID and enter
 - 添加ros2 路径，执行命令：

```
cs -s init_ros2
```
 - under ros_easy folder , type the ID and enter
 - 对于自己的工作空间也需要添加到~/.bashrc里,要不找不到包.
 - 比如你自己的工作空间walking_ws ， 执行命令

```
echo "source ~/walking_ws/install/local_setup.bash" >> ~/.bashrc
```

#### git config: 

```
git config --global user.name "ncnynl"
git config --global user.email 104391@qq.com
```


### plugin name rule

- 尽可能保持脚本名称是唯一的

```
如：安装ros1版本ailibot的仿真文件名
install_ros1_ailibot_sim.sh 

如：安装ros2版本ailibot2的仿真文件名
install_ros2_ailibot2_sim.sh
```