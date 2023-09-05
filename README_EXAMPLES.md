![logo](commands.png)


![Platform](http://img.shields.io/badge/platform-linux-blue.svg?style=flat)
![Language](http://img.shields.io/badge/language-bash-brightgreen.svg?style=flat)
![Tool](http://img.shields.io/badge/tool-shell-orange.svg?style=flat)
![License](http://img.shields.io/badge/license-MIT-red.svg?style=flat)

---

**RCM 解决了什么问题？** RCM初始设计用于管理ROS1/ROS2各类源码的安装脚本和通过界面方式启动脚本，经过不断扩展完善，目前已经成为Ubuntu/Linux下基于bash的shell脚本管理工具。

RCM是一款基于bash的智能化shell脚本管理和源码部署工具，可以管理，创建，修改脚本，利用公有脚本和私有脚本，安装和部署项目代码。安装后，可以将符合定义的shell脚本转换为以`RCM`为命令，脚本路径，脚本名称为子命令的系统命令。同时提供强大的Tab自动补全功能，实现脚本的快速查找。


提供三种模式运行脚本：

- 自动补全模式： `rcm <tab><tab> <tab><tab> <tab><tab>` （2.x系列以上支持）
- 搜索模式： `rcm -s <脚本名>` (1.x以上支持)
- 界面模式： `rcm-gui`或 `点击RCM（commands）图标`（1.x系列以上支持）


# 脚本应用目录：

- [系统相关](#系统相关)
    - [安装ROS1](#安装ROS1)

- [ROS1分类](#ROS1)
    - [安装ROS1](#安装ROS1)

- [ROS2分类](#ROS2)
    - [安装ROS2](#安装ROS2)


# 系统相关


## 更新ubuntu系统源

```sh
rcm common update_system_simple
```

## 更新python源

```sh
rcm common update_python_source_shell
```

## 更新系统时间

```sh
rcm common update_system_time
```

## 安装和更新rosdep，针对国内有奇效

```
rcm common update_rosdep_tsinghua
```

# ROS1相关


## 安装ROS1

演示通过RCM如何快速搭建ROS1 noetic版本

```sh
rcm ros1 install_ros1_noetic
```

## 安装ROS1版Ailibot仿真包

```sh
rcm ros1_ailibot install_ros1_ailibot_sim
```

## 更新ROS1源

```sh
rcm ros1 update_ros1_source
```

## 更新ROS1密钥

```sh
rcm ros1 update_ros1_key
```


# ROS2相关

## 安装ROS2

演示通过RCM如何快速搭建ROS2机器人系统，根据系统自动匹配版本，当有多个版本提示选择相应版本

```sh
rcm ros2 install_ros2_now
```

## 安装ROS2版Ailibot2仿真包

```sh
rcm ros2_ailibot2 install_ros2_ailibot2_sim
```

## 安装ROS2版walking仿真包

```sh
rcm walking_application install_walking_application
```

## 更新ROS2源

```sh
rcm ros2 update_ros2_source
```

## 更新ROS2密钥

```sh
rcm ros2 update_ros2_key
```

