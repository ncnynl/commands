#!/bin/bash
################################################
# Function : Update ROS2 turtlebot3 opencr firmware 
# Desc     : 用于安装ROS2 Turtlebot3 opencr firmware的脚本  
# Website  : https://www.ncnynl.com/archives/202110/4636.html                           
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
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Update ROS2 turtlebot3 opencr firmware")"

cs -up "arm"
if [ 1 == $? ];then 
    exit
fi 

echo "Install deps"
sudo dpkg --add-architecture armhf
sudo apt update
sudo apt install libc6:armhf

echo "Set env"
OPENCR_PORT=/dev/ttyACM0
OPENCR_MODEL=burger

echo "Download firmware"
if [ -d ~/tools/opencr_update ]; then
    rm -rf ~/tools/opencr_update 
fi

if [ ! -d ~/tools ]; then 
    mkdir ~/tools
fi 

cd ~/tools 
wget http://ghproxy.com/https://github.com/ROBOTIS-GIT/OpenCR-Binaries/raw/master/turtlebot3/ROS2/latest/opencr_update.tar.bz2

echo "Unzip firmware"
tar -xvf opencr_update.tar.bz2

echo "Flash firmware to opencr"
cd ./opencr_update
./update.sh $OPENCR_PORT $OPENCR_MODEL.opencr