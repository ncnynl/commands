#!/bin/bash
################################################
# Function : install imu m0 shell  
# Desc     : 用于源码方式安装ROS1版本惯性导航razor_imu_m0驱动的脚本                            
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-07-03 02:27:37                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
        

#run install  serial

# 

sudo apt-get install ros-noetic-serial

#run mkdir

# 
if [ ! -d ~/ros1_sensor_ws/src/ ];then
    mkdir  -p ~/ros1_sensor_ws/src/
fi

#run cd

# 

cd ~/ros1_sensor_ws/src/

#run git clone

# 

git clone https://ghproxy.com/https://github.com/ncnynl/razor_imu_m0_driver

#run cd

# 

cd ..

#run catkin_make

# 

catkin_make 


#run 

# 

cd  ~/ros1_sensor_ws/src/razor_imu_m0_driver/scripts

#run 

# 

sudo ./create_udev_rules


#replug usb

echo "Please re-connect usb! Try launch"


