#!/bin/bash
################################################
# Function : load ros1
# Desc     : 用于加载ROS1的脚本                             
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

if [ -d /opt/ros/noetic ]; then
    source /opt/ros/noetic/setup.bash
    export ROSDISTRO_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/rosdistro/index-v4.yaml
    export ROS_MASTER="http://localhost:11311"
    export ROS_HOSTNAME="localhost"
fi
