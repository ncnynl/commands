#!/bin/bash
################################################
# Function : Install ROS2 wheeltec_mic_ros2 
# Desc     : 用于源码方式安装ROS2版wheeltec_mic_ros2驱动的脚本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2024-12-09                          
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
# https://gitee.com/ncnynl/wheeltec_mic_ros2


export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ROS2 wheeltec_mic_ros2")"

# workspace       
workspace=ros2_sensor_ws

#workspace is exits ?
if [ ! -d ~/$workspace ];then 
    mkdir -p ~/$workspace/src
fi 

if [ -d ~/$workspace/src/wheeltec_mic_ros2 ];then 
    echo "velodyne have installed" && exit 0
fi 

#install rosdeps


# 下载源码
cs -si update_rosdep_tsinghua

cd ~/$workspace/src

#download wheeltec_gps
git clone https://gitee.com/ncnynl/wheeltec_mic_ros2


# 编译代码
cd ~/$workspace/
rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y
colcon build --symlink-install --packages-select wheeltec_mic_msg wheeltec_mic_ros2


#udev
echo 'KERNEL=="ttyACM*", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="55d4", MODE:="0777", SYMLINK+="wheeltec_mic"' | sudo tee /etc/udev/rules.d/wheeltec_mic.rules
# ATTRS{idVendor}=="10d6", ATTRS{idProduct}=="b003", MODE="0666"
#                     ID 1a86:55d4 QinHeng Electronics USB Single Serial
# Bus 003 Device 075: ID 2207:0001 Fuzhou Rockchip Electronics Company XFM-DP-V0.0.18
# Bus 003 Device 071: ID 1a40:0101 Terminus Technology Inc. Hub

sudo service udev reload
sleep 2
sudo service udev restart

#lib
sudo cp ~/ros2_sensor_ws/src/wheeltec_mic_ros2/wheeltec_mic_ros2/lib/x64/lib* /usr/lib/

#add to bashrc if not exits
if ! grep -Fq "$workspace/install/local_setup.bash" ~/.bashrc
then
    echo ". ~/$workspace/install/local_setup.bash" >> ~/.bashrc
    # echo "export LD_LIBRARY_PATH=~/ros2_sensor_ws/src/wheeltec_mic_ros2/wheeltec_mic_ros2/lib/x64:$LD_LIBRARY_PATH" >> ~/.bashrc
    echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi


# 启动雷达
# ros2 launch fdilink_ahrs ahrs_driver.launch.py

# 查看激光数据
# rviz2 



