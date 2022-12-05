#!/bin/bash
################################################
# Function : install_ros2_easy_20.04.sh                              
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

echo "ROS-EASY-OS20.04 Cubic ISO automation install script"
echo "Not Yet Tested"
exit 0 

pwd=$(pwd)      
echo "install galactic"
sudo sh -c "$pwd/../ros2/shell/install_ros2_galactic.sh"

echo "install noetic"
sudo sh -c "$pwd/../ros1/shell/install_ros1_noetic.sh"

echo "install tools"
sudo sh -c "$pwd/../common/shell/install_base_tools.sh"

echo "install vscode"
sudo sh -c "$pwd/../common/shell/install_vscode.sh"

echo "install nomachine"
sudo sh -c "$pwd/../common/shell/install_nomachine.sh"

echo "install rosdep"
sudo sh -c "$pwd/../common/shell/install_rosdep_tsinghua.sh"

echo "remove files"
sudo sh -c "$pwd/../common/shell/remove_unuse_tools.sh"

echo "remove zsys"
sudo sh -c "$pwd/../common/shell/remove_zsys.sh"

echo "install turtlebot3"
sudo sh -c "$pwd/../ros2_tb3/shell/install_tb3_galactic_apt.sh"

echo "install ignition"
sudo sh -c "$pwd/../ros2_ignition/shell/install_ignition_galactic_apt.sh"

