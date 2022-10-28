#!/bin/bash
################################################################
# Function :Install ROS2 Humble                                #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-07-08                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################

ros2_distro=humble

echo "Start to install ROS2 $ros2_distro"

# Install ROS 2
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

#apt source
pwd=$(pwd)
sudo sh -c "$pwd/../common/shell/update_system_mirros2.sh aliyun"
sudo apt update && sudo apt install -y curl gnupg2 lsb-release

#ros2 source
sudo curl -sSL https://mirrors.tuna.tsinghua.edu.cn/rosdistro/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://mirrors.aliyun.com/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'

#install ros2
sudo apt update
sudo apt install -y ros-$ros2_distro-desktop
sudo apt install -y python3-pip
pip3 install -U argcomplete

# Install ROS 2 RQT
sudo apt install -y ros-$ros2_distro-rqt

# Install turtlesim for verification
sudo apt install -y ros-$ros2_distro-turtlesim

# Install ROS 2 build tools
sudo apt install -y python3-colcon-common-extensions python3-vcstool

# RMW for ROS 2
sudo apt install -y ros-$ros2_distro-rmw-cyclonedds-cpp

# ros1_bridge
sudo apt install -y ros-$ros2_distro-ros1-bridge

#add ros to bashrc
sudo echo "source /opt/ros/$ros2_distro/setup.bash" >> ~/.bashrc

echo "ROS 2 $ros2_distro installed successfully"
