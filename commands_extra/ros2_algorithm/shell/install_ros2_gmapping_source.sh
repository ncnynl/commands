#!/bin/bash
################################################################
# Function :Install ROS2 gmapping source version           
# Desc     : 用于源码方式安装ROS2版激光建图算法gmapping的脚本   
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2022-06-23                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://ncnynl.com                                      
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ROS2 gmapping source version")"

workspace=ros2_algorithm_ws

if [ -d ~/$workspace/src/slam_gmapping ]; then
    echo "slam_gmapping have installed!!" 
else

    #install deps
    echo "Download ROS2 ${ROS_DISTRO} gmapping"
    if [ ! -d ~/$workspace/src ];then
        mkdir -p ~/$workspace/src
    fi

    cd ~/$workspace/src
    # git clone https://github.com/Project-MANAS/slam_gmapping
    # https://github.com/charlielito/slam_gmapping/tree/feature/namespace_launch
    git clone https://github.com/charlielito/slam_gmapping.git --branch feature/namespace_launch

    cd ~/$workspace/
    # rosdep update
    cs -si update_rosdep_tsinghua
    rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y

    #Build and install
    colcon build --symlink-install --packages-select openslam_gmapping slam_gmapping

    #add to bashrc if not exits
    echo "Please add workspace to bashrc 'cs -ss load_ros2_algorithm_ws'"
    echo "Add workspace to bashrc"
    if ! grep -Fq "ros2_algorithm_ws" ~/.bashrc
    then
        echo 'source ~/ros2_algorithm_ws/install/local_setup.bash' >> ~/.bashrc
    fi    
fi