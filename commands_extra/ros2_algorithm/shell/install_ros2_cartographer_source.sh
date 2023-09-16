#!/bin/bash
################################################################
# Function :Install ROS2 cartographer source version           
# Desc     : 用于源码方式安装ROS2版激光建图算法cartographer的脚本   
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
echo "$(gettext "Install ROS2 cartographer source version")"

workspace=ros2_cartographer_ws

if [ -d ~/$workspace ]; then
    echo "ros2 cartographer have installed!!" 
else

    #install deps
    sudo apt update
    sudo apt install -y \
        clang \
        cmake \
        g++ \
        git \
        google-mock \
        libceres-dev \
        liblua5.3-dev \
        libboost-all-dev \
        libprotobuf-dev \
        protobuf-compiler \
        libeigen3-dev \
        libgflags-dev \
        libgoogle-glog-dev \
        libcairo2-dev \
        libpcl-dev \
        libsuitesparse-dev \
        python3-sphinx \
        lsb-release \
        ninja-build \
        stow


    echo "Download ROS2 ${ROS_DISTRO} cartographer"
    if [ ! -d ~/$workspace/src ];then
        mkdir -p ~/$workspace/src
    fi


    #download package
    cd ~/$workspace/src
    git config --global url."https://ghproxy.com/https://github.com".insteadof https://github.com
    git config --global url."https://ghproxy.com/https://raw.githubusercontent.com".insteadof https://raw.githubusercontent.com

    git clone -b ros2 https://github.com/ros2/cartographer.git 
    git clone -b ros2 https://github.com/ros2/cartographer_ros.git 

    #update rosdep
    cd ~/$workspace
    cs -si update_rosdep_tsinghua
    rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y


    # install abseil
    if [[ ${ROS_DISTRO} ==  "humble" ]]; then 
        #For humble fixed error
        #https://blog.csdn.net/u011391361/article/details/131601115
        #fix1:
        # sed -i '/cmake -G Ninja/a   -DCMAKE_CXX_STANDARD=17 \\' src/cartographer/scripts/install_abseil.sh

        set -o errexit
        set -o verbose

        git clone https://github.com/abseil/abseil-cpp.git
        cd abseil-cpp
        git checkout d902eb869bcfacc1bad14933ed9af4bed006d481

        #fix2:
        # abseil-cpp/absl/debugging/failure_signal_handler.cc文件的127行
        # size_t stack_size = (std::max(SIGSTKSZ, 65536) + page_mask) & ~page_mask;
        # 改成
        # size_t stack_size = (std::max<unsigned long>(SIGSTKSZ, 65536) + page_mask) & ~page_mask;
        sed -i 's/(SIGSTKSZ/<unsigned long>(SIGSTKSZ/g' absl/debugging/failure_signal_handler.cc

        #fix3:
        # 修改abseil-cpp/absl/synchronization/internal/graphcycles.cc文件，
        # 添加  #include <limits>
        sed -i '/#include <algorithm>/a#include <limits>' absl/synchronization/internal/graphcycles.cc        

        mkdir build
        cd build
        cmake -G Ninja \
        -DCMAKE_CXX_STANDARD=17 \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
        -DCMAKE_INSTALL_PREFIX=/usr/local/stow/absl \
        ..
        ninja
        sudo ninja install
        cd /usr/local/stow
        sudo stow absl        
    else
        src/cartographer/scripts/install_abseil.sh
    fi
    

    cd ~/$workspace
    #Build and install
    colcon build --packages-up-to cartographer_ros

    if ! grep -Fq "$workspace/install/setup.bash" ~/.bashrc
    then
        echo ". ~/$workspace/install/setup.bash" >> ~/.bashrc
        echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
    else
        echo "Has been inited before! Please check ~/.bashrc"
    fi

    echo "ROS ${ROS_DISTRO} cartographer installed successfully"
fi


