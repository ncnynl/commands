#!/bin/bash
################################################
# Function : Load turtlebot3
# Desc     : 用于加载ROS1/ROS2 Turtlebot3工作空间的脚本                          
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
echo "$(gettext "Load turtlebot3")"


case "$ROS_DISTRO" in
    "noetic")
        if [ -d ~/ros1_tb3_ws ]; then
            source ~/ros1_tb3_ws/devel/setup.bash
            export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:~/ros1_tb3_ws/src/turtlebot3/turtlebot3_simulations/turtlebot3_gazebo/models

        fi
        # export ROS_DOMAIN_ID=30 #TURTLEBOT3
        export TURTLEBOT3_MODEL=burger
        export LDS_MODEL=LDS-02 #LDS-01/LDS-02
        ;;
    *)
        if [ -d ~/ros2_tb3_ws ]; then
            source ~/ros2_tb3_ws/install/setup.bash
            export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:~/ros2_tb3_ws/src/turtlebot3/turtlebot3_simulations/turtlebot3_gazebo/models
        fi
        # export ROS_DOMAIN_ID=30 #TURTLEBOT3
        export TURTLEBOT3_MODEL=burger
        export LDS_MODEL=LDS-02 #LDS-01/LDS-02
        ;;
esac