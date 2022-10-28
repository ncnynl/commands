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


# if installed ?
if [ -d ~/ros2_tb3_ws/src ]; then
    echo "Turtlebot3 have installed!!" && exit 1
fi

# install dep

sudo apt install -y python3-argcomplete python3-colcon-common-extensions python3-vcstool git
sudo apt-get install ros-galactic-gazebo-* ros-galactic-cartographer ros-galactic-cartographer-ros ros-galactic-nav2-bringup ros-galactic-navigation2 ros-galactic-slam-toolbox

# 新建工作空间
mkdir -p ~/ros2_tb3_ws/src

#run cd ros2_tb3_ws

# 进入工作空间

cd ~/ros2_tb3_ws/src

#run wget

# 获取仓库列表

# wget https://ghproxy.com/https://raw.githubusercontent.com/ROBOTIS-GIT/turtlebot3/galactic-devel/turtlebot3.repos

#run import
echo "this will take 10-30 min to download"

# 下载仓库
echo "Dowload from turtlebot3 "

git clone -b galactic-devel https://ghproxy.com/https://github.com/ROBOTIS-GIT/turtlebot3.git

echo "Dowload from turtlebot3_msgs "
git clone -b galactic-devel https://ghproxy.com/https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git

echo "Dowload from turtlebot3_simulations "
git clone -b galactic-devel https://ghproxy.com/https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git

echo "Dowload from DynamixelSDK "
git clone -b galactic-devel https://ghproxy.com/https://github.com/ROBOTIS-GIT/DynamixelSDK.git

echo "Dowload from hls_lfcd_lds_driver "
git clone -b galactic-devel https://ghproxy.com/https://github.com/ROBOTIS-GIT/hls_lfcd_lds_driver.git


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

