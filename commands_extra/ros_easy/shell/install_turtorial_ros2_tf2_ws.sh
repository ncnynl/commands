#!/bin/bash
################################################
# Function : install turtorial ros2 tf2 ws 
# Desc     : 用于构建学习ROS2 TF2代码工作空间的脚本                             
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

if [ ! -d ~/ros2_tf2_ws ]; then
    cd ~
    git clone https://gitee.com/ncnynl/ros2_tf2_ws
    cd ~/ros2_tf2_ws
    colcon build --symlink-install
    echo "Install successfully!"
else
    echo "Has been installed before"
fi

echo "Please source ~/ros2_tf2_ws/install/local_setup.bash"