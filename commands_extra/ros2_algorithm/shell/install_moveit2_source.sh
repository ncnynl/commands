#!/bin/bash
################################################################
# Function :Install ROS2 Moveit2 source version           
# Desc     :用于源码方式安装ROS2版Moveit2算法的脚本   
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-14                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://ncnynl.com | https://moveit.ros.org/install-moveit2/source/                                      
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ROS2 Moveit2 source version")"

workspace=ros2_moveit2_ws

if [ -d ~/$workspace/src/moveit2 ]; then
    echo "ros2 Moveit2 have installed!!" 
else

    #install deps
    sudo apt update
    
    sudo apt install -y \
        build-essential \
        cmake \
        git \
        python3-colcon-common-extensions \
        python3-flake8 \
        python3-rosdep \
        python3-setuptools \
        python3-vcstool \
        wget




    echo "Download ROS2 ${ROS_DISTRO} moveit2"
    if [ ! -d ~/$workspace/src/ ];then
        mkdir -p ~/$workspace/src
    fi


    #download package
    cd ~/$workspace/src

    git clone https://github.com/moveit/moveit2.git -b $ROS_DISTRO
    for repo in moveit2/moveit2.repos $(f="moveit2/moveit2_$ROS_DISTRO.repos"; test -r $f && echo $f); do vcs import < "$repo"; done


    if [ ! -d ~/$workspace/src/moveit2 ]; then 
        echo "moveit2 is no exists! "
        exit 0
    fi 

    #update rosdep
    cd ~/$workspace
    cs -si update_rosdep_tsinghua
    rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y


    
    cd ~/$workspace
    #Build and install
    colcon build --executor sequential --event-handlers desktop_notification- status- --cmake-args -DCMAKE_BUILD_TYPE=Release

    # colcon build \ 
    #     --executor sequential \
    #     --cmake-args -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \ 
    #     --ament-cmake-args -DCMAKE_BUILD_TYPE=Release

    if ! grep -Fq "$workspace/install/setup.bash" ~/.bashrc
    then
        echo ". ~/$workspace/install/setup.bash" >> ~/.bashrc
        echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
    else
        echo "Has been inited before! Please check ~/.bashrc"
    fi

    echo "ROS ${ROS_DISTRO} moveit2 installed successfully"
fi


