#!/bin/bash
################################################
# Function : Install Ailibot2_SIM ROS2 ${ROS_DISTRO} source 
# Desc     : 用于源码方式安装ROS2 humble版本Ailibot2_sim的脚本                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-08-17 15:25:09                            
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
echo "$(gettext "Install Ailibot2_SIM ROS2 ${ROS_DISTRO} source")"

# echo "Tested ROS2 Version: galactic , humble"
# if installed ?
if [ -d ~/ros2_ailibot2_sim_ws/src ]; then
    echo "ailibot2_sim have installed!!" 
else 

    # install dep
    sudo apt-get update
    sudo apt install -y ros-${ROS_DISTRO}-teleop-twist-keyboard 
    sudo apt install -y ros-${ROS_DISTRO}-urdf  ros-${ROS_DISTRO}-xacro 
    sudo apt install -y ros-${ROS_DISTRO}-navigation2 ros-${ROS_DISTRO}-nav2-bringup 
    sudo apt install -y ros-${ROS_DISTRO}-compressed-image-transport ros-${ROS_DISTRO}-rqt-tf-tree
    sudo apt install -y ros-${ROS_DISTRO}-slam-toolbox  ros-${ROS_DISTRO}-cartographer ros-${ROS_DISTRO}-cartographer-ros
    sudo apt install -y ros-${ROS_DISTRO}-robot-localization

    #install gmapping
    cs -si install_ros2_gmapping_source
    source ~/ros2_algorithm_ws/install/local_setup.bash

    # 新建工作空间
    mkdir -p ~/ros2_ailibot2_sim_ws/src

    # 进入工作空间
    cd ~/ros2_ailibot2_sim_ws/src

    # 获取仓库列表
    #run import
    echo "this will take 5 min to download"

    # 下载仓库
    echo "Dowload ailibot2_sim"
    git clone  https://gitee.com/ncnynl/ailibot2_sim

    # 编辑各个包
    echo "build workspace..."
    cd ~/ros2_ailibot2_sim_ws 
    cs -si update_rosdep_tsinghua
    rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y
    colcon build --symlink-install

    # 添加工作空间路径到bashrc文件
    echo "Add workspace to bashrc"
    if ! grep -Fq "ros2_ailibot2_sim_ws" ~/.bashrc
    then
        echo 'source ~/ros2_ailibot2_sim_ws/install/local_setup.bash' >> ~/.bashrc
        echo 'export ROSDISTRO_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/rosdistro/index-v4.yaml ' >> ~/.bashrc
    fi

fi