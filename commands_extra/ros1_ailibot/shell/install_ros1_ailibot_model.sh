#!/bin/bash
################################################
# Function : Install ROS1 Ailibot_Model  noetic source 
# Desc     : 用于源码方式安装ROS1 noetic版本Ailibot_Model的脚本                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-08-17 15:25:09                            
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
echo "$(gettext "Install ROS1 Ailibot_Model source")"

# if installed ?
workspace=ros1_ailibot_model_new_ws

if [ -d ~/$workspace/src ]; then
    echo "ailibot_model have installed!!" 
else 

    # install dep
    sudo apt-get install ros-noetic-joy ros-noetic-teleop-twist-joy \
        ros-noetic-teleop-twist-keyboard ros-noetic-laser-proc \
        ros-noetic-rgbd-launch ros-noetic-rosserial-arduino \
        ros-noetic-rosserial-python ros-noetic-rosserial-client \
        ros-noetic-rosserial-msgs ros-noetic-amcl ros-noetic-map-server \
        ros-noetic-move-base ros-noetic-urdf ros-noetic-xacro \
        ros-noetic-compressed-image-transport ros-noetic-rqt* ros-noetic-rviz \
        ros-noetic-gmapping ros-noetic-navigation ros-noetic-interactive-markers \
        ros-noetic-slam-karto ros-noetic-hector-mapping 

    # 新建工作空间
    mkdir -p ~/$workspace/src

    # 进入工作空间
    cd ~/$workspace/src

    # 获取仓库列表
    #run import
    echo "this will take a while to download"

    # 下载仓库
    echo "Dowload ailibot_model"
    git clone  https://gitee.com/ncnynl/ailibot_model

    echo "Dowload realsense_ros_gazebo plugin"
    git clone https://github.com/EndlessLoops/realsense_ros_gazebo

    #rosdep 
    cs -si update_rosdep_tsinghua

    # 编辑各个包
    echo "build workspace..."
    cd ~/$workspace
    rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y
    catkin_make

    # 添加工作空间路径到bashrc文件
    echo "Add workspace to bashrc"
    if ! grep -Fq $workspace ~/.bashrc
    then
        echo "source ~/$workspace/devel/setup.bash" >> ~/.bashrc
    fi

fi