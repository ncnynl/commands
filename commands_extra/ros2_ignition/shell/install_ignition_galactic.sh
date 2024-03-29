#!/bin/bash
################################################
# Function : Install ROS2 ignition shell 
# Desc     : 用于源码方式安装ROS2 galactic版ignition仿真的脚本                             
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-07-06 18:22:04                            
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
echo "$(gettext "Install ROS2 ignition shell")" 

#run 

# 

sudo apt install ros-galactic-ros-ign -y

#run 

# 

mkdir -p ~/ros2_ign_ws/src

#run 

# 

git clone https://github.com/osrf/ros_ign.git -b galactic

#run 

# 

cd ~/ros2_ign_ws/

#run 

# 安装依赖

rosdep install -r --from-paths src -i -y --rosdistro galactic

#run 

# 编译

colcon build --symlink-install

#run 

# 加载工作空间

. ~/ros2_ign_ws/install/local_setup.bash

#run 

# 



