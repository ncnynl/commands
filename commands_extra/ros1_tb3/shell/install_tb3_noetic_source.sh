#!/bin/bash
################################################
# Function : install_turtlebot3_ros1_noetic_source.sh                              
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
#run ros2_tb3_ws


# if installed ?
if [ -d ~/ros1_tb3_ws/src ]; then
    echo "Turtlebot3 have installed!!" 
else 

    #install apt first 
    pwd=$(pwd)
    sudo sh -c "$pwd/../ros1_tb3_gazebo/shell/install_turtlebot3_ros1_noetic_apt.sh"

    # install dep
    sudo apt install -y python3-argcomplete python3-colcon-common-extensions python3-vcstool git

    # 新建工作空间
    mkdir -p ~/ros1_tb3_ws/src

    #run cd ros2_tb3_ws

    # 进入工作空间

    cd ~/ros1_tb3_ws/src

    #run wget

    # 获取仓库列表

    #run import
    echo "this will take 10-30 min to download"

    # 下载仓库
    echo "Dowload from turtlebot3 "

    git clone -b noetic-devel https://ghproxy.com/https://github.com/ROBOTIS-GIT/turtlebot3.git

    echo "Dowload from turtlebot3_msgs "
    git clone -b noetic-devel https://ghproxy.com/https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git

    echo "Dowload from turtlebot3_simulations "
    git clone -b noetic-devel https://ghproxy.com/https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git

    echo "Dowload from DynamixelSDK "
    git clone -b noetic-devel https://ghproxy.com/https://github.com/ROBOTIS-GIT/DynamixelSDK.git

    echo "Dowload from hls_lfcd_lds_driver "
    git clone -b noetic-devel https://ghproxy.com/https://github.com/ROBOTIS-GIT/hls_lfcd_lds_driver.git


    #run colcon

    # 编辑各个包
    echo "build workspace..."
    cd ~/ros1_tb3_ws && catkin_make

    #run echo

    # 添加工作空间路径到bashrc文件
    if ! grep -Fq "ros1_tb3_ws" ~/.bashrc
    then
        echo 'source ~/ros1_tb3_ws/devel/setup.bash' >> ~/.bashrc
    fi
    #run echo

    # export GAZEBO_MODEL_PATH
    if ! grep -Fq "turtlebot3_gazebo/models" ~/.bashrc
    then
        echo 'export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:~/ros1_tb3_ws/src/turtlebot3/turtlebot3_simulations/turtlebot3_gazebo/models' >> ~/.bashrc
    fi

    # export TURTLEBOT3_MODEL
    if ! grep -Fq "TURTLEBOT3_MODEL" ~/.bashrc
    then
        echo 'export TURTLEBOT3_MODEL=burger' >> ~/.bashrc
    fi

fi