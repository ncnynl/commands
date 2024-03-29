#!/bin/bash
################################################
# Function : Install openmanipulator_p ROS1 melodic source 
# Desc     : 用于源码方式安装ROS1 melodic版本openmanipulator_p的脚本                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-04-22 15:25:09                            
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
echo "$(gettext "Install openmanipulator_p ROS1 melodic source")"


# if installed ?
if [ -d ~/ros1_op_ws/src ]; then
    echo "openmanipulator_p have installed!!" 
else 

    # install dep
    sudo apt install -y ros-melodic-ros-controllers ros-melodic-gazebo* ros-melodic-moveit* ros-melodic-industrial-core

    # 新建工作空间
    mkdir -p ~/ros1_op_ws/src

    #run cd ros2_tb3_ws

    # 进入工作空间

    cd ~/ros1_op_ws/src

    # 获取仓库列表
    #run import
    echo "this will take 10-30 min to download"

    # 下载仓库
    echo "Dowload DynamixelSDK"

    git clone -b melodic-devel https://github.com/ROBOTIS-GIT/DynamixelSDK.git

    echo "Dowload from dynamixel-workbench "
    git clone -b melodic-devel https://github.com/ROBOTIS-GIT/dynamixel-workbench.git

    echo "Dowload from dynamixel-workbench-msgs "
    git clone -b melodic-devel https://github.com/ROBOTIS-GIT/dynamixel-workbench-msgs.git

    echo "Dowload from open_manipulator_p "
    git clone -b melodic-devel https://github.com/ROBOTIS-GIT/open_manipulator_p.git

    echo "Dowload from open_manipulator_msgs "
    git clone -b melodic-devel https://github.com/ROBOTIS-GIT/open_manipulator_msgs.git

    echo "Dowload from open_manipulator_p_simulations "
    git clone -b melodic-devel https://github.com/ROBOTIS-GIT/open_manipulator_p_simulations.git

    echo "Dowload from robotis_manipulator "
    git clone -b melodic-devel https://github.com/ROBOTIS-GIT/robotis_manipulator.git

    echo "Dowload from open_manipulator_p_controls for moveit"
    git clone  https://github.com/ROBOTIS-GIT/open_manipulator_p_controls.git

    echo "Dowload from open_manipulator_dependencies for moveit"
    git clone  https://github.com/ROBOTIS-GIT/open_manipulator_dependencies.git  

    # 编辑各个包
    echo "build workspace..."
    cd ~/ros1_op_ws
    cs -si update_rosdep_tsinghua
    rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y
    catkin_make

    #run echo
    echo  "Update USB Latency Timer Setting: "
    echo "1. roscore, 2.rosrun open_manipulator_p_controller create_udev_rules"

    # 添加工作空间路径到bashrc文件
    echo "Add workspace to bashrc"
    if ! grep -Fq "ros1_op_ws" ~/.bashrc
    then
        echo 'source ~/ros1_op_ws/devel/setup.bash' >> ~/.bashrc
    fi

fi