#!/bin/bash
################################################
# Function : Update ROS1 turtlebot3 opencr firmware 
# Desc     : 用于安装ROS1 Turtlebot3 opencr firmware的脚本  
# Website  : https://www.ncnynl.com/archives/202111/4819.html                           
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-03-17 15:25:09                            
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
echo "$(gettext "Update ROS1 turtlebot3 opencr firmware")"

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
OPENCR_MODEL=burger_noetic

echo "Download firmware"
if [ -d ~/tools/opencr_update ]; then
    rm -rf ~/tools/opencr_update 
    rm -rf ~/tools/opencr_update.tar.bz2
fi

if [ ! -d ~/tools ]; then 
    mkdir ~/tools
fi 

cd ~/tools 
wget http://ghproxy.com/https://github.com/ROBOTIS-GIT/OpenCR-Binaries/raw/master/turtlebot3/ROS1/latest/opencr_update.tar.bz2

echo "Unzip firmware"
tar -xvf opencr_update.tar.bz2

echo "Flash firmware to opencr"
cd ./opencr_update
sudo chmod 777 /dev/ttyACM0
./update.sh $OPENCR_PORT $OPENCR_MODEL.opencr