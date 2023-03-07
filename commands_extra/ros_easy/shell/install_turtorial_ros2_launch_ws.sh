#!/bin/bash
################################################
# Function : Install tutorial ros2 launch ws   
# Desc     : 用于构建学习ROS2 launch代码工作空间的脚本                              
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
echo "$(gettext "Install tutorial ros2 launch ws")"

if [ ! -d ~/ros2_launch_ws ]; then
    cd ~
    git clone https://gitee.com/ncnynl/launch_ws ros2_launch_ws
    cd ~/ros2_launch_ws
    colcon build --symlink-install  
    echo "Install successfully!"
else
    echo "Has been installed before"
fi

echo "Please source ~/ros2_launch_ws/install/local_setup.bash"