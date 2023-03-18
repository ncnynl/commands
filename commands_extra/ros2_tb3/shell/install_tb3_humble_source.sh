#!/bin/bash
################################################
# Function : Install ROS2 humble turtlebot3 source version 
# Desc     : 用于源码方式安装ROS2 Humble版Turtlebot3的脚本  
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
echo "$(gettext "Install ROS2 humble turtlebot3 source version")"

#run ros2_tb3_ws
# echo "Not Yet Supported!"
# exit 0


# if installed ?
if [ -d ~/ros2_tb3_ws/src ]; then
    echo "Turtlebot3 have installed!!" 
else
    # install dep

    sudo apt install -y python3-argcomplete python3-colcon-common-extensions python3-vcstool git libudev-dev
    sudo apt install -y ros-humble-gazebo-ros2-control \
    ros-humble-gazebo-ros-pkgs \
    ros-humble-gazebo-ros2-control-demos \
    ros-humble-gazebo-dev \
    ros-humble-gazebo-ros \
    ros-humble-gazebo-plugins \
    ros-humble-gazebo-msgs \
    ros-humble-cartographer \
    ros-humble-cartographer-ros \
    ros-humble-nav2-bringup \
    ros-humble-navigation2 \
    ros-humble-slam-toolbox

    #rosdep update
    sudo apt install python3-rosdep -y
    . ~/commands/common/shell/update_rosdep_tsinghua.sh
    rosdep update

    # 新建工作空间
    mkdir -p ~/ros2_tb3_ws/src

    #run cd ros2_tb3_ws

    # 进入工作空间

    cd ~/ros2_tb3_ws/src

    #run wget

    # 获取仓库列表

    # wget https://ghproxy.com/https://raw.githubusercontent.com/ROBOTIS-GIT/turtlebot3/humble-devel/turtlebot3.repos

    #run import
    echo "this will take 10-30 min to download"

    # 下载仓库
    echo "Dowload from turtlebot3 "

    git clone -b humble-devel https://ghproxy.com/https://github.com/ROBOTIS-GIT/turtlebot3.git

    echo "Dowload from turtlebot3_msgs "
    git clone -b humble-devel https://ghproxy.com/https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git

    echo "Dowload from turtlebot3_simulations "
    git clone -b humble-devel https://ghproxy.com/https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git

    echo "Dowload from DynamixelSDK "
    git clone -b humble-devel https://ghproxy.com/https://github.com/ROBOTIS-GIT/DynamixelSDK.git

    echo "Dowload from hls_lfcd_lds_driver "
    git clone -b humble-devel https://ghproxy.com/https://github.com/ROBOTIS-GIT/hls_lfcd_lds_driver.git

    echo "Dowload from ld08_driver "
    git clone -b humble-devel https://ghproxy.com/https://github.com/ROBOTIS-GIT/ld08_driver.git

    #run colcon

    # 编辑各个包
    echo "build workspace..."
    cd ~/ros2_tb3_ws/
    rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y
    colcon build --symlink-install --parallel-workers 1

    #run echo

    # 添加工作空间路径到bashrc文件

    # echo 'source ~/ros2_tb3_ws/install/setup.bash' >> ~/.bashrc
    # echo 'source ~/ros2_tb3_ws/install/setup.bash' >> ~/.bashrc

    #run echo

    # 添加ROS_DOMAIN_ID到bashrc文件

    # echo 'export ROS_DOMAIN_ID=30 #TURTLEBOT3' >> ~/.bashrc

    # export GAZEBO_MODEL_PATH
    # echo 'export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:~/ros2_tb3_ws/src/turtlebot3/turtlebot3_simulations/turtlebot3_gazebo/models' >> ~/.bashrc

    # export TURTLEBOT3_MODEL
    # echo 'export TURTLEBOT3_MODEL=burger' >> ~/.bashrc

    #run source

    # 加载工作空间到当前环境
    sh -c "~/commands/ros_easy/shell/init_tb3.sh"
    source ~/.bashrc

fi