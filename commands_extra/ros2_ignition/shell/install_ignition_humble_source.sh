#!/bin/bash
################################################
# Function : install_ignition_humble_source.sh
# Desc     : 用于源码方式安装ROS2 humble版仿真软件ignition的脚本                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-11-19                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
#没测试        

mkdir -p ~/ros2_ign_ws/src

#run 

# 

git clone https://github.com/osrf/ros_ign.git -b humble

#run 

# 

cd ~/ros2_ign_ws/

#run 

# 安装依赖

rosdep install -r --from-paths src -i -y --rosdistro humble

#run 

# 编译

colcon build --symlink-install

#run 

# 加载工作空间

. ~/ros2_ign_ws/install/local_setup.bash

#run 

# 



