#!/bin/bash
################################################
# Function : Install ROS2 ros2_xsens_mti_driver  
# Desc     : 用于源码方式安装ROS2版ros2_xsens_mti_driver驱动的脚本                        
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2024-07-31                             
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920        
# Website: https://github.com/DEMCON/ros2_xsens_mti_driver                       
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ROS2 ros2_xsens_mti_driver")"

     
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
git clone https://gitee.com/ncnynl/ros2_xsens_mti_driver

# 编译代码
cd ~/$workspace/
colcon build --symlink-install --packages-select ros2_xsens_mti_driver

#add to bashrc if not exits
if ! grep -Fq "$workspace/install/local_setup.bash" ~/.bashrc
then
    echo ". ~/$workspace/install/local_setup.bash" >> ~/.bashrc
    echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi


# 启动雷达
# ros2 launch ros2_xsens_mti_driver xsens_mti_node.launch.py
# ros2 topic echo /filter/quaternion
# ros2 launch ros2_xsens_mti_driver display.launch.py

# 查看激光数据
# rviz2 



