#!/bin/bash
################################################
# Function : install_tutorial_ros2_code_ws.sh                              
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

if [ ! -d ~/ros2_code_ws ]; then
    cd ~
    git clone https://github.com/ncnynl/ros2_ws ros2_code_ws
    cd ~/ros2_code_ws
    colcon build --symlink-install 
    echo "Install successfully!"
else
    echo "Has been installed before"
fi

echo "Please source ~/ros2_code_ws/install/local_setup.bash"