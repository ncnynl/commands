#!/bin/bash
################################################
# Function : Install ROS2 humble open_manipulator_x source version 
# Desc     : 用于源码方式安装ROS2 Humble版open_manipulator_x的脚本  
# Website  : https://www.ncnynl.com/archives/202210/5574.html                           
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-06-30 15:25:09                            
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
echo "$(gettext "Install ROS2 humble open_manipulator_x source version")"

#run ros2_tb3_ws
# echo "Not Yet Supported!"
# exit 0


# if installed ?
if [ -d ~/ros2_openmanipulatorx_ws/src ]; then
    echo " open_manipulatorx have installed!!" 
else
    # install dep

    sudo apt install \
    ros-humble-dynamixel-sdk \
    ros-humble-ros2-control \
    ros-humble-moveit* \
    ros-humble-gazebo-ros2-control \
    ros-humble-ros2-controllers \
    ros-humble-controller-manager \
    ros-humble-position-controllers \
    ros-humble-joint-state-broadcaster \
    ros-humble-joint-trajectory-controller \
    ros-humble-gripper-controllers \
    ros-humble-hardware-interface \
    ros-humble-xacro

    #rosdep update
    sudo apt install python3-rosdep -y
    . ~/commands/common/shell/update_rosdep_tsinghua.sh
    # rosdep update
    cs -si update_rosdep_tsinghua


    # 新建工作空间
    mkdir -p ~/ros2_openmanipulatorx_ws/src

    #run cd ros2_tb3_ws

    # 进入工作空间

    cd ~/ros2_openmanipulatorx_ws/src

    # 下载仓库
    echo "Download code "

    git clone -b humble https://github.com/ROBOTIS-GIT/open_manipulator.git
    git clone -b humble https://github.com/ROBOTIS-GIT/dynamixel_hardware_interface.git
    git clone -b humble https://github.com/ROBOTIS-GIT/dynamixel_interfaces.git

    #run colcon

    # 编辑各个包
    echo "build workspace..."
    cd ~/ros2_openmanipulatorx_ws/
    colcon build --symlink-install --parallel-workers 1

    #run echo

    # 添加工作空间路径到bashrc文件

    echo 'source ~/ros2_openmanipulatorx_ws/install/setup.bash' >> ~/.bashrc

    # 加载工作空间到当前环境
    source ~/.bashrc

fi
