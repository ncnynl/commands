#!/bin/bash
################################################################
# Function :Install ROS2 slam_toolbox source version           
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
echo "$(gettext "Install ROS2 slam_toolbox source version")"

workspace=ros2_algorithm_ws

if [ -d ~/$workspace/src/slam_toolbox ]; then
    echo "slam_toolbox have installed!!" 
else

    #install deps
    echo "Download ROS2 ${ROS_DISTRO} slam_toolbox"
    if [ ! -d ~/$workspace/src ];then
        mkdir -p ~/$workspace/src
    fi

    cd ~/$workspace/src
    git clone -b ${ROS_DISTRO} https://github.com/SteveMacenski/slam_toolbox

    cd ~/$workspace/
    # rosdep update
    cs -si update_rosdep_tsinghua
    rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y

    #Build and install
    colcon build --symlink-install --packages-select slam_toolbox

    #add to bashrc if not exits
    echo "Please add workspace to bashrc 'cs -ss load_ros2_algorithm_ws'"
    echo "Add workspace to bashrc"
    if ! grep -Fq "ros2_algorithm_ws" ~/.bashrc
    then
        echo 'source ~/ros2_algorithm_ws/install/local_setup.bash' >> ~/.bashrc
    fi    
fi