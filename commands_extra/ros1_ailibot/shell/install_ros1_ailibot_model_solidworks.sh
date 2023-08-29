#!/bin/bash
################################################
# Function : Install ROS1 Ailibot_Model_origin  noetic source 
# Desc     : 用于源码方式安装ROS1 noetic版本Ailibot_Model_origin的脚本                              
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
echo "$(gettext "Install ROS1 Ailibot_Model_origin source")"

# if installed ?
workspace=ros1_ailibot_model_ws

if [ -d ~/$workspace/src ]; then
    echo "ailibot_model_origin have installed!!" 
else 

    # install dep
    # 新建工作空间
    mkdir -p ~/$workspace/src

    # 进入工作空间
    cd ~/$workspace

    git clone https://gitee.com/ncnynl/ailibot_model_solidworks
    cp -r ailibot_model_solidworks/ailibot_model_origin src/ailibot_model

    cd ~/$workspace/src

    # 获取仓库列表
    #run import
    echo "this will take some times to download"
    echo "Dowload realsense_ros_gazebo plugin"
    git clone https://github.com/EndlessLoops/realsense_ros_gazebo

    #rosdep 
    cs -si update_rosdep_tsinghua

    # 编辑各个包
    echo "build workspace..."
    cs -s update_rosdep
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