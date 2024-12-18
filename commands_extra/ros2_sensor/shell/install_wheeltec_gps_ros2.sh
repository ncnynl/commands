#!/bin/bash
################################################
# Function : Install ROS2 wheeltec_gps 
# Desc     : 用于源码方式安装ROS2版wheeltec_gps驱动的脚本                         
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
# https://github.com/jinmenglei/serial_ros2
# https://gitee.com/ncnynl/wheeltec_gps_ros2


export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ROS2 wheeltec_gps")"

# echo "Not Yet Supported!"
# exit 0   
# workspace       
workspace=ros2_sensor_ws

#workspace is exits ?
if [ ! -d ~/$workspace ];then 
    mkdir -p ~/$workspace/src
fi 

if [ -d ~/$workspace/src/wheeltec_gps_ros2 ];then 
    echo "wheeltec_gps_ros2 have installed" && exit 0
fi 

#install rosdeps


# 下载源码
cs -si update_rosdep_tsinghua

cd ~/$workspace/src

#download wheeltec_gps
git clone https://gitee.com/ncnynl/wheeltec_gps_ros2


# 编译代码
cd ~/$workspace/
rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y

colcon build --symlink-install --packages-select nmea_msgs nmea_navsat_driver wheeltec_gps_path

#build wheeltec_udev
echo 'KERNEL=="ttyACM*", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="55d4", MODE:="0777", SYMLINK+="wheeltec_gps"' | sudo tee /etc/udev/rules.d/wheeltec_gps.rules
sudo service udev reload
sleep 2
sudo service udev restart

#add to bashrc if not exits
if ! grep -Fq "$workspace/install/local_setup.bash" ~/.bashrc
then
    echo ". ~/$workspace/install/local_setup.bash" >> ~/.bashrc
    echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi


# 启动雷达
# ros2 launch fdilink_ahrs ahrs_driver.launch.py

# 查看激光数据
# rviz2 



