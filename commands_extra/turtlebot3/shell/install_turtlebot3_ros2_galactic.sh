#!/bin/bash
################################################
# Function : install_turtlebot3_ros2_galactic.sh                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-06-30 15:25:09                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
#run ros2_tb3_ws

# 新建工作空间

mkdir -p ~/ros2_tb3_ws/src

#run cd ros2_tb3_ws

# 进入工作空间

cd ~/ros2_tb3_ws

#run wget

# 获取仓库列表

# wget https://ghproxy.com/https://raw.githubusercontent.com/ROBOTIS-GIT/turtlebot3/galactic-devel/turtlebot3.repos

echo ""                              > turtlebot3.repos
echo "repositories:"                 >> turtlebot3.repos
echo "  turtlebot3/turtlebot3:"      >> turtlebot3.repos
echo "    type: git"                 >> turtlebot3.repos
echo "    url: https://ghproxy.com/https://github.com/ROBOTIS-GIT/turtlebot3.git"            >> turtlebot3.repos
echo "    version: galactic-devel"   >> turtlebot3.repos
echo "  turtlebot3/turtlebot3_msgs:" >> turtlebot3.repos
echo "    type: git"                 >> turtlebot3.repos
echo "    url: https://ghproxy.com/https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git"       >> turtlebot3.repos
echo "    version: galactic-devel"   >> turtlebot3.repos
echo "  turtlebot3/turtlebot3_simulations:" >> turtlebot3.repos
echo "    type: git"                 >> turtlebot3.repos
echo "    url: https://ghproxy.com/https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git" >> turtlebot3.repos
echo "    version: galactic-devel"   >> turtlebot3.repos
echo "  utils/DynamixelSDK:"         >> turtlebot3.repos
echo "    type: git"                 >> turtlebot3.repos
echo "    url: https://ghproxy.com/https://github.com/ROBOTIS-GIT/DynamixelSDK.git"           >> turtlebot3.repos
echo "    version: galactic-devel"   >> turtlebot3.repos
echo "  utils/hls_lfcd_lds_driver:"  >> turtlebot3.repos
echo "    type: git"            >> turtlebot3.repos
echo "    url: https://ghproxy.com/https://github.com/ROBOTIS-GIT/hls_lfcd_lds_driver.git"    >> turtlebot3.repos
echo "    version: galactic-devel"   >> turtlebot3.repos

#run import

# 下载仓库
echo "Dowload from repo "
vcs import src < turtlebot3.repos

#run colcon

# 编辑各个包
echo "build workspace..."
colcon build --symlink-install

#run echo

# 添加工作空间路径到bashrc文件

echo 'source ~/ros2_tb3_ws/install/setup.bash' >> ~/.bashrc

#run echo

# 添加ROS_DOMAIN_ID到bashrc文件

echo 'export ROS_DOMAIN_ID=30 #TURTLEBOT3' >> ~/.bashrc

# export GAZEBO_MODEL_PATH
echo 'export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:~/ros2_tb3_ws/src/turtlebot3/turtlebot3_simulations/turtlebot3_gazebo/models' >> ~/.bashrc

# export TURTLEBOT3_MODEL
echo 'export TURTLEBOT3_MODEL=burger' >> ~/.bashrc

#run source

# 加载工作空间到当前环境

source ~/.bashrc

