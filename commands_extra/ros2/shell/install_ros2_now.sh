#!/bin/bash
################################################################
# Function :Install ROS2 AMD/ARM version                    
# Desc     : 用于安装ROS2版本的脚本
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

cpu=$(uname -m)
version=$(awk -F'[= "]' '/VERSION_ID/{print $3}' /etc/os-release)

case $version in 
    "22.04")
        ros2_distro=humble,rolling,iron
        ;;
    "20.04")
        ros2_distro=foxy,galactic 
        ;;
    *);;
esac

CHOICE_A=$(echo -e "\n Your Ubuntu System is $version, Please Choose ROS2 Version [$ros2_distro] ：")
read -p "${CHOICE_A}" ros_ver

#if exits ?
if [ -f /opt/ros/$ros_ver/setup.bash ]; then
    echo "You have installed ROS2 Version $ros_ver"
    exit
fi

case $ros_ver in 
    "foxy")
        if [ $cpu == "x86_64" ]; then
            echo "Your cpu release is x86_64, please install AMD version "
            cs -si install_ros2_foxy_amd.sh
        elif [ $cpu == "aarch64" ]; then
            echo "Your cpu release is aarch64, please install ARM version "
            cs -si install_ros2_foxy_arm.sh
        fi
        ;;

    "galactic")
        if [ $cpu == "x86_64" ]; then
            echo "Your cpu release is x86_64, please install AMD version "
            cs -si install_ros2_galactic_amd.sh
        elif [ $cpu == "aarch64" ]; then
            echo "Your cpu release is aarch64, please install ARM version "
            cs -si install_ros2_galactic_arm.sh
        fi
        ;;

    "humble")

        if [ $cpu == "x86_64" ]; then
            echo "Your cpu release is x86_64, please install AMD version "
            cs -si install_ros2_humble_amd.sh
        elif [ $cpu == "aarch64" ]; then
            echo "Your cpu release is aarch64, please install ARM version "
            cs -si install_ros2_humble_arm.sh
        fi
        ;;
    "rolling"|"iron")
        if [ $cpu == "x86_64" ]; then
            echo "Your cpu release is x86_64, please install AMD version "
            arch="amd"
        elif [ $cpu == "aarch64" ]; then
            echo "Your cpu release is aarch64, please install ARM version "
            arch="arm"
        fi

        cs -si install_ros2_common.sh $ros_ver $arch

        exit
        ;;               
    *)
        CHOICE_A=$(echo -e "\n You have a wrong ROS2 version, If try again!!![Y/n] ：")
        read -p "${CHOICE_A}" YN
        case $YN in 
            [Yy] | [Yy][Ee][Ss])
                cs -si install_ros2_now.sh
                ;;
            *)
                exit
                ;;
        esac     
        ;;
esac

#install rosdep 
cs -si update_rosdep_tsinghua