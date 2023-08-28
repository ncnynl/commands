#!/bin/bash
################################################
# Function : Install ROS2 Micro ROS source 
# Desc     : 用于源码方式安装ROS2 Micro ROS的脚本                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-08-26                           
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install Micro ROS for ROS2 ${ROS_DISTRO} source")"

# echo "Tested ROS2 Version: galactic , humble"
# if installed ?
if [ -d ~/ros2_micro_ros_ws/src/micro_ros_setup ]; then
    echo "Micro ROS have installed!!" 
else 

    # install dep
    sudo apt-get update
    sudo apt-get install python3-pip

    #install openocd
    sudo apt install -y openocd
    sudo apt install -y arm-none-eabi-gcc arm-none-eabi-gdb

    #install micro ros dds
    cs -si install_micro_ros_dds
    cs -si install_stlink

    # 新建工作空间
    mkdir -p ~/ros2_micro_ros_ws/src

    # 进入工作空间
    cd ~/ros2_micro_ros_ws/src

    # 获取仓库列表
    #replace https
    git config --global url."https://ghproxy.com/https://github.com".insteadof https://github.com

    #run import
    echo "this will take 5 min to download"

    # 下载仓库
    echo "Dowload micro_ros"
    git clone -b $ROS_DISTRO https://github.com/micro-ROS/micro_ros_setup.git micro_ros_setup

    # 编辑各个包
    echo "build workspace..."
    cd ~/ros2_micro_ros_ws 
    cs -si update_rosdep_tsinghua
    rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y
    colcon build --symlink-install

    # 添加工作空间路径到bashrc文件
    echo "Add workspace to bashrc"
    if ! grep -Fq "ros2_micro_ros_ws" ~/.bashrc
    then
        echo 'source ~/ros2_micro_ros_ws/install/local_setup.bash' >> ~/.bashrc
    fi

fi