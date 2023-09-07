#!/bin/bash
################################################################
# Function :Install ROS1 Noetic Cartographer                               #
# Desc     : 用于安装ROS1 Noetic版本建图算法Cartographer的脚本
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-06-23                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ROS1 Noetic Cartographer")"

if [ -d ~/ros1_carto_ws ]; then
    echo "ros1 noetic cartographer have installed!!" 
else

    #install deps
    sudo apt-get update
    sudo apt-get install -y python3-wstool python3-rosdep ninja-build stow

    echo "Download ROS1 ${ROS_DISTRO} cartographer"

    mkdir ~/ros1_carto_ws
    cd ~/ros1_carto_ws
    wstool init src
    #wstool merge -t src https://raw.githubusercontent.com/cartographer-project/cartographer_ros/master/cartographer_ros.rosinstall
    #commit_id: cartographer ef00de2 
    #commit_id: cartographer_ros c138034 

    echo "- git: {local-name: cartographer, uri: 'https://ghproxy.com/https://github.com/cartographer-project/cartographer.git', version: 'master'}
    - git: {local-name: cartographer_ros, uri: 'https://ghproxy.com/https://github.com/cartographer-project/cartographer_ros.git', version: 'master'}" > cartographer_ros.rosinstall
    wstool merge -t src cartographer_ros.rosinstall
    wstool update -t src

    #update rosdep
    #sudo rosdep init
    # rosdep update
    cs -si update_rosdep_tsinghua
    rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y

    #Due to conflicting versions you might need to uninstall the ROS abseil-cpp using
    # sudo apt-get remove ros-${ROS_DISTRO}-abseil-cpp

    #install abseil
    sed -i 's/github.com/ghproxy.com\/https:\/\/github.com/'g src/cartographer/scripts/install_abseil.sh
    src/cartographer/scripts/install_abseil.sh

    #Build and install
    catkin_make_isolated --install --use-ninja

    #add ros to bashrc
    sudo echo "source ~/ros1_carto_ws/install_isolated/setup.bash" >> ~/.bashrc

    echo "ROS ${ROS_DISTRO} cartographer installed successfully"

fi


