#!/bin/bash
################################################
# Function : Load ROS2  
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
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Load ROS2")"

# . ~/commands/common/shell/check_linux_version.sh
release=""
version=""
function get_system(){
    if cat /etc/issue | grep -Eqi "ubuntu"; then
        release="ubuntu"
    elif cat /proc/version | grep  -Eqi  "ubuntu"; then
        release="ubuntu"
    fi
    # echo "release:$release"
}
get_system

function get_system_version(){
    if [ $1 == "ubuntu" ]; then
        version=$(awk -F'[= "]' '/VERSION_ID/{print $3}' /etc/os-release)
    fi
    # echo "version:$version"
}
get_system_version $release

# echo $release
# echo $version 
# echo $ROS_DISTRO

case $version in 
    "22.04")
        ros2_distro=humble
        ;;
    "20.04")
        # ros2_distro=galactic
        #if galactic exits , use first, if always use foxy, please change it
        if [ -d /opt/ros/galactic ]; then
            ros2_distro=galactic 
        else
            ros2_distro=foxy
        fi 
        ;;
    *);;
esac

# echo $ros2_distro

if [ -d /opt/ros/$ros2_distro ]; then
    source /opt/ros/$ros2_distro/setup.bash
    export ROSDISTRO_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/rosdistro/index-v4.yaml
    source /usr/share/colcon_cd/function/colcon_cd.sh
fi
