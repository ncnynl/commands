#!/bin/bash
################################################
# Function : Install ros2 easy arm 22.04  
# Desc     : 用于制作ROS-EASY-OS-ARM 22.04镜像自动化脚本                            
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
echo "$(gettext "Install ros2 easy arm 22.04")"

echo "ROS-EASY-OS-ARM 22.04 for RPI4 automation install script"
echo "Not Yet Tested"
# exit 0 

pwd=$(pwd)      
echo "install humble"
rcm -si install_ros2_humble_arm.sh

echo "install tools"
# rcm -si install_base_tools.sh

echo "install vscode"
# rcm -si install_vscode.sh

# echo "install nomachine"
# rcm -si install_nomachine.sh

echo "install rosdep"
rcm -si install_rosdep_tsinghua.sh

# echo "remove files"
# sudo sh -c "$pwd/../common/shell/remove_unuse_tools.sh"

# echo "remove zsys"
# sudo sh -c "$pwd/../common/shell/remove_zsys.sh"

# echo "install turtlebot3"
# sudo sh -c "$pwd/../ros2_tb3/shell/install_tb3_humble_apt.sh"

# echo "install ignition"
# sudo sh -c "$pwd/../ros2_ignition/shell/install_ignition_humble_apt.sh"
