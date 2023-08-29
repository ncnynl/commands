#!/bin/bash
################################################
# Function : Install Ailibot_SIM ROS1 noetic source 
# Desc     : 用于源码方式安装ROS1 noetic版本Ailibot_sim的脚本                              
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
echo "$(gettext "Install Ailibot_SIM ROS1 noetic source")"


# if installed ?
if [ -d ~/ros1_ailibot_sim_ws/src ]; then
    echo "ailibot_sim have installed!!" 
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
    mkdir -p ~/ros1_ailibot_sim_ws/src

    # 进入工作空间
    cd ~/ros1_ailibot_sim_ws/src

    # 获取仓库列表
    #run import
    echo "this will take 5 min to download"

    # 下载仓库
    echo "Dowload ailibot_sim"
    git clone  https://gitee.com/ncnynl/ailibot_sim

    echo "Dowload realsense_ros_gazebo plugin"
    git clone https://github.com/EndlessLoops/realsense_ros_gazebo

    #rosdep 
    cs -si update_rosdep_tsinghua
    
    # 编辑各个包
    echo "build workspace..."
    cd ~/ros1_ailibot_sim_ws 
    rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y
    catkin_make

    # 添加工作空间路径到bashrc文件
    echo "Add workspace to bashrc"
    if ! grep -Fq "ros1_ailibot_sim_ws" ~/.bashrc
    then
        echo 'source ~/ros1_ailibot_sim_ws/devel/setup.bash' >> ~/.bashrc
        echo 'export ROSDISTRO_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/rosdistro/index-v4.yaml ' >> ~/.bashrc
        echo 'export AILIBOTBASE=d4    
        echo 'export ROS_NAMESPACE=""
        echo 'export ROS_MULTI=false
        echo 'export GAZEBO=true
    fi

fi