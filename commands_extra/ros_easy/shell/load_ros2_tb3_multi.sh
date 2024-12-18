#!/bin/bash
################################################
# Function : Load turtlebot3 multi
# Desc     : 用于加载ROS1/ROS2 Turtlebot3 multi工作空间的脚本                          
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-03-21                            
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
echo "$(gettext "Load turtlebot3 multi")"

if [ -d ~/ros2_tb3_multi_ws ]; then
    source ~/ros2_tb3_multi_ws/install/setup.bash
    export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:~/ros2_tb3_multi_ws/src/turtlebot3/turtlebot3_simulations/turtlebot3_gazebo/models
    # export ROS_DOMAIN_ID=30 #TURTLEBOT3
    export TURTLEBOT3_MODEL=burger
    export LDS_MODEL=LDS-02 #LDS-01/LDS-02
fi
