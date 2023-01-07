#!/bin/bash
################################################
# Function : install ros2 easy arm 20.04 
# Desc     : 用于制作ROS-EASY-OS-ARM 20.04镜像自动化脚本                               
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

echo "ROS-EASY-OS-ARM 20.04 For Navida NX automation install script"
echo "Not Yet Tested"
exit 0 

pwd=$(pwd)      

echo "install foxy"
sudo sh -c "$pwd/../ros2/shell/install_ros2_foxy_arm.sh"

echo "install noetic"
sudo sh -c "$pwd/../ros1/shell/install_ros1_noetic_arm.sh"

echo "install tools"
sudo sh -c "$pwd/../common/shell/install_base_tools.sh"

echo "install vscode"
sudo sh -c "$pwd/../common/shell/install_vscode.sh"

echo "install nomachine"
# sudo sh -c "$pwd/../common/shell/install_nomachine.sh"

echo "install rosdep"
sudo sh -c "$pwd/../common/shell/install_rosdep_tsinghua.sh"

echo "remove files"
# sudo sh -c "$pwd/../common/shell/remove_unuse_tools.sh"

echo "remove zsys"
# sudo sh -c "$pwd/../common/shell/remove_zsys.sh"

echo "install turtlebot3"
sudo sh -c "$pwd/../ros2_tb3/shell/install_tb3_foxy_apt.sh"