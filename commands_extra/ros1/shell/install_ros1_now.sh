#!/bin/bash
################################################################
# Function :Install ROS1 AMD/ARM version                    
# Desc     : 用于安装ROS1版本的脚本
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
echo "$(gettext "Install ROS1 AMD/ARM version")"

cpu=$(uname -m)
version=$(awk -F'[= "]' '/VERSION_ID/{print $3}' /etc/os-release)

case $version in 
    "20.04")
        ros1_distro=noetic 
        ;;
    "18.04")
        ros1_distro=melodic 
        ;;
    "16.04")
        ros1_distro=kinetic 
        ;;        
    *);;
esac

CHOICE_A=$(echo -e "\n Your Ubuntu System is $version, Please Choose ROS1 Version [$ros1_distro] ：")
read -p "${CHOICE_A}" ros_ver

#if exits ?
if [ -f /opt/ros/$ros_ver/setup.bash ]; then
    echo "You have installed ROS1 Version $ros_ver"
    exit
fi

case $ros_ver in 
    "noetic")
        if [ $cpu == "x86_64" ]; then
            echo "Your cpu release is x86_64, please install AMD version "
            cs -si install_ros1_noetic.sh
        elif [ $cpu == "aarch64" ]; then
            echo "Your cpu release is aarch64, please install ARM version "
            cs -si install_ros1_noetic_arm.sh
        fi
        ;;

    "melodic")
        if [ $cpu == "x86_64" ]; then
            echo "Your cpu release is x86_64, please install AMD version "
            cs -si install_ros1_melodic.sh
        elif [ $cpu == "aarch64" ]; then
            echo "Your cpu release is aarch64, please install ARM version "
            cs -si install_ros1_melodic.sh
        fi
        ;;

    "kinetic")

        if [ $cpu == "x86_64" ]; then
            echo "Your cpu release is x86_64, please install AMD version "
            cs -si install_ros1_kinetic.sh
        elif [ $cpu == "aarch64" ]; then
            echo "Your cpu release is aarch64, please install ARM version "
            cs -si install_ros1_kinetic.sh
        fi
        ;;

    *)
        CHOICE_A=$(echo -e "\n You have a wrong ROS1 version, If try again!!![Y/n] ：")
        read -p "${CHOICE_A}" YN
        case $YN in 
            [Yy] | [Yy][Ee][Ss])
                cs -si install_ros1_now.sh
                ;;
            *)
                exit
                ;;
        esac     
        ;;
esac

#install rosdep 
cs -si update_rosdep_tsinghua