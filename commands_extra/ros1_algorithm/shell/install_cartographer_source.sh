#!/bin/bash
################################################################
# Function :Install ROS1 Noetic Cartographer                               #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-06-23                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################

workspace=ros1_cartographer_ws

if [ -d ~/$workspace ]; then
    echo "ros1 cartographer have installed!!" 
else

    #install deps
    sudo apt-get update
    sudo apt-get install -y python3-wstool python3-rosdep ninja-build stow

    echo "Download ROS1 ${ROS_DISTRO} cartographer"
    if [ ! -d ~/$workspace/src ];then
        mkdir -p ~/$workspace/src
    fi

    cd ~/$workspace
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
    rosdep update
    rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y

    #Due to conflicting versions you might need to uninstall the ROS abseil-cpp using
    # sudo apt-get remove ros-${ROS_DISTRO}-abseil-cpp

    #install abseil
    sed -i 's/github.com/ghproxy.com\/https:\/\/github.com/'g src/cartographer/scripts/install_abseil.sh
    src/cartographer/scripts/install_abseil.sh

    #Build and install
    catkin_make_isolated --install --use-ninja

    #add to bashrc if not exits
    if ! grep -Fq "$workspace/install_isolated/setup.bash" ~/.bashrc
    then
        echo ". ~/$workspace/install/local_setup.bash" >> ~/.bashrc
        echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
    else
        echo "Has been inited before! Please check ~/.bashrc"
    fi    

    echo "ROS ${ROS_DISTRO} cartographer installed successfully"
fi


