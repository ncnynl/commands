#!/bin/bash
################################################
# Function : Install ROS2 rplidar_ros2  
# Desc     : 用于源码方式安装ROS2版单线激光雷达RPlidar驱动的脚本                        
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-12-08                             
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
echo "$(gettext "Install ROS2 rplidar_ros2")"

# cs -si install_sllidar_ros2.sh

     
# echo "Not Yet Supported!"
# exit 0      
workspace=ros2_sensor_ws

#workspace is exits ?
if [ ! -d ~/$workspace ];then 
    mkdir -p ~/$workspace/src
fi 

if [ -d ~/$workspace/src/rplidar_ros ];then 
    echo "rplidar_ros have installed" && exit 0
fi 

# 下载源码
cd ~/$workspace/src
git clone -b ros2  https://github.com/Slamtec/rplidar_ros

# 编译代码
cd ~/$workspace/
colcon build --symlink-install --packages-select rplidar_ros

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



