#!/bin/bash
################################################################
# Function :Install ROS1 Melodic                                
# Desc     : 用于安装ROS1 Melodic
# Website  : https://www.ncnynl.com/archives/202211/5714.html
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
echo "$(gettext "Install ROS1 Melodic")"

if [ -d /opt/ros/melodic ]; then
    echo "ros1 Melodic have installed!!" 
else

    ros1_distro=melodic

    echo "Start to install ROS1 $ros1_distro"

    # Install ROS 1
    sudo apt update && sudo apt install -y curl gnupg2 lsb-release

    # Add ros source
    # curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
    sudo sh -c 'echo "deb http://mirrors.aliyun.com/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
    sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
    sudo apt update
    sudo apt install -y ros-$ros1_distro-desktop-full

    # Install ROS 1 build tools
    sudo apt install -y python3-rosdep python3-rospkg python3-rosinstall-generator python3-vcstool build-essential 

    sudo apt install -y ros-$ros1_distro-rqt ros-$ros1_distro-rqt-common-plugins  ros-$ros1_distro-tf2-tools  
    # ros-$ros1_distro-tf2-echo 

    #add ros to bashrc
    sudo echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc

    echo "ROS $ros1_distro installed successfully"

fi