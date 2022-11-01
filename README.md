# commands

#### 介绍

 - 通过命令管理器方便管理所有的ROS1/ROS2命令, 可以导出命令列表，导入命令列表
 - https://www.ncnynl.com/archives/202206/5316.html


 #### 使用说明参考

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
ubuntu 20.04 
ros2 galactic
ros1 noetic
python3.8 
pyqt5
```



#### 在线安装教程

 - 一键安装

```
rm online.sh ; wget https://gitee.com/ncnynl/commands/raw/master/online.sh ; sudo chmod +x ./online.sh; ./online.sh
```

 - 新开终端,输入commands

```
commands
```

#### 编译源码

cd ~/tools/commands/commands_src
- 编译
./build

- 文件生成在dist，可以直接执行
./dist/commands

#### 本地编译源码并进行安装

cd ~/tools/commands/
- 运行
./install.sh

#### 编辑脚本后独立安装commans_exra目录下脚本

cd ~/tools/commands/
- 运行
./install_extra.sh

#### 配置说明


 - 对于系统命令,如ls top ps等可以直接使用
 - 对于ros1或ros2命令, 需要添加ros1或ros2的路径到当前用户的~/.bashrc里
 - 添加ros1 路径，执行命令:

```
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
```
 - 添加ros2 路径，执行命令：

```
echo "source /opt/ros/galactic/setup.bash" >> ~/.bashrc
```

 - 对于自己的工作空间也需要添加到~/.bashrc里,要不找不到包.
 - 比如你自己的工作空间walking_ws ， 执行命令

```
echo "source ~/walking_ws/install/local_setup.bash" >> ~/.bashrc
```

