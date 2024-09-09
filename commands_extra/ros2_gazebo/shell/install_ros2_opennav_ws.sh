#!/bin/bash
################################################
# Function : Install ros2 opennav_amd_demonstrations gazebo shell  
# Desc     : 源码安装opennav_amd_demonstrations仿真的脚本    
# Website  : https://www.ncnynl.com/                   
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2024-08-31                          
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ros2 opennav_amd_demonstrations gazebo shell")"
# echo "Not Supported Yet!"
# exit 0  
echo ""
echo "Set workspace"
workspace=ros2_opennav_ws

echo ""
echo "Set soft name"
soft_name=opennav_amd_demonstrations

if [ ! -d ~/$workspace/src ] ; then 
    mkdir -p ~/$workspace/src/
fi

echo ""
echo "Software if installed ?"
if [ -d ~/$workspace/src/$soft_name ];then 
    echo "$soft_name have installed" && exit 0
fi 

echo ""
echo "Install system deps"


sudo apt install ros-${ROS_DISTRO}-gazebo-ros-pkgs
sudo apt install ros-${ROS_DISTRO}-ros2-control
sudo apt install ros-${ROS_DISTRO}-ros2-controllers
sudo apt install ros-${ROS_DISTRO}-pointcloud-to-laserscan
sudo apt install ros-${ROS_DISTRO}-nav2-graceful-controller
sudo apt install ros-${ROS_DISTRO}-nav2-*
sudo apt install ros-$ROS_DISTRO-robot-localization

#3D Localization
sudo apt install ros-${ROS_DISTRO}-spatio-temporal-voxel-layer
sudo apt install libpcap-dev

#GPS
sudo apt install ros-$ROS_DISTRO-mapviz
sudo apt install ros-$ROS_DISTRO-mapviz-plugins
sudo apt install ros-$ROS_DISTRO-tile-map


# 下载源码
echo ""
echo "Download source"
cd ~/$workspace/src/
git clone -b $ROS_DISTRO https://github.com/ncnynl/nav2_opennav
# # git clone  https://github.com/ncnynl/opennav_amd_demonstrations
# git clone  https://gitee.com/ncnynl/opennav_amd_demonstrations

# cd ~/$workspace/src/opennav_amd_demonstrations/
# git clone  -b humble https://github.com/open-navigation/opennav_docking

# #https://github.com/open-navigation/opennav_amd_demonstrations/blob/main/deps.repos
# cd ~/$workspace/src/

# #for real
# # Generally required
# # git clone -b humble https://github.com/micro-ROS/micro-ROS-Agent.git
# # git clone --recurse-submodules -b ros2  https://github.com/ouster-lidar/ouster-ros.git
# # git clone -b  main https://github.com/orbbec/OrbbecSDK_ROS2
# # git clone -b 0.2.11 https://github.com/clearpathrobotics/clearpath_robot.git

# #for sim
# # For GPS demo
# git clone -b humble https://github.com/SteveMacenski/nonpersistent_voxel_layer
# # For ground segmentation
# git clone -b master https://github.com/url-kaist/patchwork-plusplus
# # For 3D SLAM and Localization
# # git clone -b develop https://github.com/rsasaki0109/lidarslam_ros2.git
# git clone -b humble https://github.com/rsasaki0109/lidarslam_ros2.git
# git clone -b main https://github.com/rsasaki0109/lidar_localization_ros2.git
# git clone -b humble https://github.com/rsasaki0109/ndt_omp_ros2.git


if [ ! -d ~/$workspace/src/$soft_name ];then 
    echo "Download failed, please try again!" && exit 0
fi

echo ""
echo "Install rosdeps"
cs -si update_rosdep_tsinghua
cd ~/$workspace/
rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y


# 编译代码
echo "Compile source"
cd ~/$workspace/
colcon build --symlink-install --parallel-workers 1


echo "Add workspace to bashrc if not exits"
if ! grep -Fq "$workspace/install/local_setup.bash" ~/.bashrc
then
    echo ". ~/$workspace/install/local_setup.bash" >> ~/.bashrc
    echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi

#How to use


