#!/bin/bash
################################################
# Function : Install ros2 easy 22.04 
# Desc     : 用于制作ROS-EASY-OS-AMD 22.04镜像自动化脚本                               
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
echo "$(gettext "Install ros2 easy 22.04")"

echo "ROS-EASY-OS-AMD 22.04 Cubic ISO automation install script"
echo "Not Yet Tested"
# exit 0 

pwd=$(pwd)      
echo "install humble"
rcm -si install_ros2_humble.sh

echo "install iron or rolling"
# rcm ros2 install_ros2_now 

echo "install tools"
# rcm -si install_base_tools.sh

echo "install vscode"
# rcm -si install_vscode.sh

echo "install nomachine"
# rcm -si install_nomachine.sh

echo "install rosdep"
# rcm -si install_rosdep_tsinghua.sh
rcm -si update_rosdep_tsinghua

echo "remove files"
rcm -si remove_unuse_tools.sh

echo "remove zsys"
rcm -si remove_zsys.sh

echo "install turtlebot3"
# rcm -si install_tb3_humble_apt.sh

echo "install ignition"
# rcm -si install_ignition_humble_apt.sh
