#!/bin/bash
################################################
# Function : install_example_shell.sh                         
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
# echo "Not  Supported Yet!"
# exit 0    

echo "set workspace"
# workspace=workspace_ws

echo "set soft name"
#soft_name=name

echo "workspace if exits ?"
# if [ ! -d ~/$workspace ];then 
#     mkdir -p ~/$workspace/src
# fi 

echo "software if installed ?"
# if [ -d ~/$workspace/src/$soft_name ];then 
#     echo "$soft_name have installed" && exit 0
# fi 

echo "install rosdeps"
# sudo apt install ros-${ROS-DISTRO}-diagnostic-updater
# sudo apt install libpcap0.8-dev

# 下载源码
echo "Download source"
# cd ~/$workspace/src
# git clone -b galactic-devel https://github.com/ros-drivers/velodyne.git
# rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y


# 编译代码
echo "Compile source"
# cd ~/$workspace/
# colcon build --symlink-install 


echo "add workspace to bashrc if not exits"
# if ! grep -Fq "$workspace/install/local_setup.bash" ~/.bashrc
# then
#     echo ". ~/$workspace/install/local_setup.bash" >> ~/.bashrc
#     echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
# else
#     echo "Has been inited before! Please check ~/.bashrc"
# fi


# 启动雷达
echo "How to use"
# ros2 launch sllidar_ros2 view_sllidar_launch.py  #A1/A2
# ros2 launch sllidar_ros2 view_sllidar_a3_launch.py #A3
# ros2 launch sllidar_ros2 view_sllidar_s1_launch.py  #S1
# ros2 launch sllidar_ros2 view_sllidar_s2_launch.py  #S2
# ros2 launch sllidar_ros2 view_sllidar_t1_launch.py  #T1
# ros2 launch sllidar_ros2 view_sllidar_s1_tcp_launch.py  T1 tcp

# 查看激光数据
# rviz2 



