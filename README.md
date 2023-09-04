![logo](commands.png)


![Platform](http://img.shields.io/badge/platform-linux-blue.svg?style=flat)
![Language](http://img.shields.io/badge/language-bash-brightgreen.svg?style=flat)
![Tool](http://img.shields.io/badge/tool-shell-orange.svg?style=flat)
![License](http://img.shields.io/badge/license-MIT-red.svg?style=flat)

---

**RCM 解决了什么问题？** RCM初始设计用于管理ROS1/ROS2各类源码的安装脚本和通过界面方式启动脚本，已经不断扩展完善，目前已经成为Ubuntu/Linux下基于bash的shell脚本管理工具。

RCM是一个基于bash的shell脚本管理工具。安装后，可以将符合定义的shell脚本转换为以`RCM`为命令，脚本路径，脚本名称为子命令的系统命令。同时提供强大的Tab自动补全功能，实现脚本的快速查找。


提供三种模式运行脚本：

- 搜索模式： `rcm -s <脚本名>` (1.x以上支持)
- 界面模式： `rcm -py` 或 `点击RCM（commands）图标`（1.x系列以上支持）
- 自动补全模式： `rcm <tab><tab> <tab><tab> <tab><tab>` （2.x系列以上支持）

# 目录：

- [RCM是什么?](#RCM是什么)
- [为什么使用RCM?](#为什么使用RCM)
- [特色](#特色)
- [安装](#安装)
- [卸载](#卸载)
- [结构](#结构)
- [参考](#参考)
- [如何为 rcm 添加命令?](#如何为-rcm-添加命令?)
    - [创建子命令](#创建子命令)
    - [创建脚本](#创建脚本)
    - [编辑脚本](#编辑脚本)
    - [执行脚本](#执行脚本)
    - [编译](#编译)
    - [调试模式](#调试模式)
    - [帮助提示](#帮助提示)
- [开发提示](#开发提示)
    - [环境变量](#环境变量)
    - [脚本参数](#脚本参数)
    - [命名规范](#命名规范)
    - [函数定义](#函数定义)
    - [函数引用](#函数引用)
    - [私有脚本](#私有脚本)
    - [工具依赖](#工具依赖)
    - [私有配置](#私有配置)
    - [编程语法](#编程语法)
- [License](#license)

## RCM是什么

RCM是一个基于BASH和桌面的快捷shell脚本管理工具。安装后，可以将符合定义的shell脚本转换为以`RCM`为命令，脚本路径，脚本名称为子命令的系统命令。同时提供强大的Tab自动补全功能，实现脚本的快速查找。

提供三种模式运行脚本：

- 搜索模式： `rcm -s <脚本名>` (1.x以上支持)
- 界面模式： `rcm-gui`（1.x系列以上支持）
- 自动补全模式： `rcm <tab><tab> <tab><tab> <tab><tab>` （2.x系列以上支持）

## 为什么使用RCM

从15年开始接触到ros开始，就一直采用shell脚本的方式搭建ros环境，遇到无数的坑
相信你如果一直都使用ros，难免跟我一样会遇到如下问题：

- rosdep update 因为网站连接问题，经常不好用
- ros1/ros2的国外源经常出错或导致安装缓慢
- ubuntu系统国外源也经常出错或导致安装缓慢
- python的国外源也经常出错或导致安装缓慢
- 各种包的版本问题，各种安装异常
- ros1/ros2包源码安装，经常不成功
- 不同架构下的，安装方法也不一样

所以需要保证每次安装的统一： 统一的环境，统一配置，统一的安装方式 尽可能减少出现问题的概率。

单个版本解决方法，就是每次安装好，赶紧备份一个版本，出问题就恢复一下，继续干活，但是，每当一个新的ros版本出来，难免就要升级，上面的问题不可避免的又出来了。

我就想，如果开发一个工具，写好安装脚本，大家可以共享，很多问题，就可以避免，毕竟这个脚本是大家经过测试的。

每个人可以自己根据安装的流程，生成一个执行脚本，通过这个脚本来完成相应的工作，就可以达到统一化
如果每个人可以把自己的脚本共享出来，这个脚本就可以实现了复用，大家就可以节省很多时间。

因为维护统一脚本，出现问题，更容易解决。根据不同的需求，也可以建立不同的脚本来解决。
基于上面的需求开发了这个工具。比如我想安装ros1， 找到这个脚本，点击一键安装即可，多简单。

上述问题，适合所有采用shell脚本进行安装和维护的情况。


## 特色

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
- RCM支持搜索查找方式运行
- RCM支持自动补全查找方式运行
- RCM支持界面查找方式运行

### 搜索模式：

<动图显示>

### 界面模式：

![rcm](images/main.png)

### 自动补全模式：


<动图显示>

## 安装

### 桌面版/完整版： 界面需要ubuntu桌面下运行，shell在终端下运行。需要进行python代码的编译

 - 一键安装桌面版
 - 方法一：

```
curl -k http://file.ncnynl.com/rcm.sh | bash -
```

- 方法二：

```
curl -k https://gitee.com/ncnynl/commands/raw/master/online.sh | bash -
```

 - 新开终端,输入:

```
commands
```

### 命令行版： shell在终端下运行, 不需要进行python代码编译

 - 一键安装命令行版
 - 方法一：

```
curl -k http://file.ncnynl.com/rcms.sh | bash -
```

 - 方法二： 

 ```
curl -k https://gitee.com/ncnynl/commands/raw/master/online_shell.sh | bash -
```

 - 新开终端,输入:

```
rcm <tab><tab>
```

## 卸载

```
./tools/commands/uninstall.sh
```

## 结构

- 目录树

```
├── CHANGELOG.rst        #日志
├── commands_completion  #自动补全相关目录
├── commands.desktop     #桌面
├── commands_docker      #docker相关目录（待完善）
├── commands_extra       #所有命令相关目录
├── commands_i18n        #多语言相关目录
├── commands.png         #LOGO
├── commands_src         #桌面版源码相关目录
├── config_git.sh        #git配置
├── desktop.sh           #桌面调用脚本
├── images               #图片相关目录
├── install_completion.sh#自动补全安装脚本
├── install_desktop.sh   #桌面安装脚本
├── install_docker.sh    #docker安装脚本（待完善）
├── install_extra.sh     #shell脚本安装脚本
├── install_i18n.sh      #多语言安装脚本
├── install.sh           #桌面版安装脚本
├── install_shell.sh     #命令行版安装脚本
├── install_simple.sh    #简化版使用脚本
├── install_src.sh       #桌面版编译脚本
├── LICENSE              #开源协议
├── logo.png             #logo
├── online_docker.sh     #docker版在线安装脚本
├── online.sh            #桌面版在线安装脚本
├── online_shell.sh      #命令行版在线安装脚本
├── README.md            #本文件
├── shell.sh             #更新所有脚本
├── sync_extra.sh        #同步应用目录的脚本到开发目录下
├── sync_gitee.sh        #不升级更新代码
├── test                 #测试相关目录
├── uninstall.sh         #卸载
└── version.txt          #版本
```

- 本程序的所有源码都安装在用户根目录`~/tools/commands`下
- 本程序的脚本分成两个目录，应用目录和开发目录，两者相互独立不影响使用和开发。
- 应用目录: 在用户根目录下的`~/commands`目录下
- 开发目录：在用户根目下的~/tools/commands/commands_extra目录下
- 开发好的脚本，通过运行./install_extra.sh同步到应用目录即可使用

 ## 参考

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


## 如何为-rcm-添加命令



## 软件架构

```
ubuntu 20.04 +
ros2 galactic+
ros1 noetic
python3.8 
pyqt5
```


## 编译源码

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

### 本地编译源码并进行安装

```
cd ~/tools/commands/
```

- 运行

```
./install_src.sh
```

### 脚本同步

- 编辑脚本后独立安装commans_exra目录下脚本

- 已整合为命令行版本，可以单独使用

```
cd ~/tools/commands/
```

- 运行

```
./install_extra.sh
```

## 共享脚本代码
#### How to add scripts to this repo
 
- 1. fork repo / 克隆代码分支仓库
- 2. add your scripts / 增加代码到自己的分支仓库
- 3. submit the scripts to your repo / 提交代码到自己的分支仓库
- 4. pull request to this repo / 推送变化代码到主仓库
- 5. we will check your scripts / 审核相关代码
- 6. all ok , merge to this repo / 合并到主仓库


## 配置说明


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

## git config: 

```
git config --global user.name "ncnynl"
git config --global user.email 104391@qq.com
```


## plugin name rule

- 尽可能保持脚本名称是唯一的

```
如：安装ros1版本ailibot的仿真文件名
install_ros1_ailibot_sim.sh 

如：安装ros2版本ailibot2的仿真文件名
install_ros2_ailibot2_sim.sh
```


## shell编码规范

- ![参考Google的Shell风格指南](https://zh-google-styleguide.readthedocs.io/en/latest/google-shell-styleguide/contents/)