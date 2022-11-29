#!/bin/bash
################################################
# Function : install_pointcloud_to_laserscan.sh                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-11-29                             
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
#     
echo "Not Yet Supported!"
exit 0       
workspace=ros2_sensor_ws

#workspace is exits ?
if [ ! -d ~/$workspace ];then 
    mkdir -p ~/$workspace/src
fi 

if [ -d ~/$workspace/src/pointcloud_to_laserscan ];then 
    echo "pointcloud_to_laserscan have installed" && exit 0
fi 

# 下载源码
cd ~/$workspace/src
git clone -b ${ROS_DISTRO} https://github.com/ros-perception/pointcloud_to_laserscan

# compile
cd ~/$workspace/
colcon build --symlink-install  --packages-select pointcloud_to_laserscan

#add to bashrc if not exits
if ! grep -Fq "$workspace/install/local_setup.bash" ~/.bashrc
then
    echo ". ~/$workspace/install/local_setup.bash" >> ~/.bashrc
    echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi


# 启动雷达
# ros2 launch sllidar_ros2 view_sllidar_launch.py  #A1/A2
# ros2 launch sllidar_ros2 view_sllidar_a3_launch.py #A3
# ros2 launch sllidar_ros2 view_sllidar_s1_launch.py  #S1
# ros2 launch sllidar_ros2 view_sllidar_s2_launch.py  #S2
# ros2 launch sllidar_ros2 view_sllidar_t1_launch.py  #T1
# ros2 launch sllidar_ros2 view_sllidar_s1_tcp_launch.py  T1 tcp

# 查看激光数据
# rviz2 



