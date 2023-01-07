#!/bin/bash
################################################
# Function : load ros2  
# Desc     : 用于加载ROS2的脚本                             
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-11-21                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################

. ~/commands/common/shell/check_linux_version.sh

# echo $release
# echo $version 
# echo $ROS_DISTRO

case $version in 
    "22.04")
        ros2_distro=humble
        ;;
    "20.04")
        # ros2_distro=galactic
        ros2_distro=foxy
        ;;
    *);;
esac

# echo $ros2_distro

if [ -d /opt/ros/$ros2_distro ]; then
    source /opt/ros/$ros2_distro/setup.bash
    export ROSDISTRO_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/rosdistro/index-v4.yaml
    source /usr/share/colcon_cd/function/colcon_cd.sh
fi
