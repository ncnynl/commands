#!/bin/bash
################################################################
# Function :Install ROS2 AMD/ARM version                    
# Desc     : 用于AMD/ARM架构下安装ROS2版本的公共脚本,通过install_ros2_now来调用
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2022-07-08                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://ncnynl.com                                      
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ROS2 AMD/ARM version")"

# echo $3
# echo $4 

if [ ! $3 ]; then 
    echo "Please choose ros2 version"
    exit 1
fi 

if [ ! $4 ]; then 
    echo "Please choose cpu arch version"
    exit 1    
fi

# exit

ros2_distro=$3
ros2_arch=$4

#if exits ?
if [ -f /opt/ros/$ros2_distro/setup.bash ]; then
    echo "You have installed ROS2 Version $ros2_distro"
    exit
fi

echo "Start to install ROS2 $ros2_distro"


#update and upgrade first 
sudo apt update 
sudo apt upgrade 

# Install ROS 2
sudo apt install -y locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

#apt source
# pwd=$(pwd)
# sudo sh -c "$pwd/../common/shell/update_system_simple.sh aliyun"
if [ $ros2_arch == "amd" ]; then 
    cs -si update_system_simple
fi 

sudo apt install -y curl gnupg lsb-release

# sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
#ros2 source
sudo curl -sSL https://mirrors.tuna.tsinghua.edu.cn/rosdistro/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://mirrors.aliyun.com/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'

#install ros2
sudo apt install -y ros-$ros2_distro-desktop-full
sudo apt install -y python3-argcomplete python3-pip 
sudo apt install -y ros-dev-tools

# Install ROS 2 RQT
sudo apt install -y ros-$ros2_distro-rqt
sudo apt install -y ros-$ros2_distro-rqt-tf-tree

# Install turtlesim for verification
sudo apt install -y ros-$ros2_distro-turtlesim

# Install ROS 2 build tools
sudo apt install -y \
python3-colcon-common-extensions \
python3-vcstool \
python3-rosdep

# RMW for ROS 2
sudo apt install -y ros-$ros2_distro-rmw-cyclonedds-cpp
sudo apt install -y ros-$ros2_distro-rmw-fastrtps-cpp

#install tf2 deps
sudo apt install -y \
ros-$ros2_distro-turtle-tf2-py \
ros-$ros2_distro-tf2-tools \
ros-$ros2_distro-tf-transformations

#install ros2 bag deps
if [ $ros2_arch == "amd" ]; then 
    sudo apt install -y \
    libroscpp-serialization0d \
    ros-$ros2_distro-nmea-msgs \
    ros-$ros2_distro-rosbag2  \
    ros-$ros2_distro-rosbag2-storage \
    ros-$ros2_distro-rosbag2-storage-default-plugins \
    ros-$ros2_distro-ros2bag \
    ros-$ros2_distro-rosbag2-transport 
fi

#add ros to bashrc
sudo echo "source /opt/ros/$ros2_distro/setup.bash" >> ~/.bashrc

echo "ROS 2 $ros2_distro installed successfully"

#uninstall
# sudo apt remove ~nros-iron-* && sudo apt autoremove
# sudo rm /etc/apt/sources.list.d/ros2.list
# sudo apt update
# sudo apt autoremove