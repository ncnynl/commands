#!/bin/bash
################################################
# Function : Update ROS2 turtlebot3 opencr firmware 
# Desc     : 用于安装ROS2 Turtlebot3 opencr firmware的脚本  
# Website  : https://www.ncnynl.com/archives/202110/4636.html                           
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
echo "$(gettext "Update ROS2 turtlebot3 opencr firmware")"

echo "Install deps"

#for arm
if [ $(uname -m) == "aarch64" ];then 
    sudo dpkg --add-architecture armhf
    sudo apt update
    sudo apt install libc6:armhf
fi 

echo "Set env"

if [ ! -e /dev/ttyACM0 ]; then 
    echo "Don't have found the port /dev/ttyACM0 "
    exit
else 
    echo "Have found the port /dev/ttyACM0 "
    OPENCR_PORT=/dev/ttyACM0
fi 

echo ""
echo " 1 - burger" 
echo " 2 - waffle or waffle-pi"
CHOICE_A=$(echo -e "\n${BOLD}└ $(gettext "Please select OPENCR_MODEL"):${PLAIN}")
read -p "${CHOICE_A}" INPUT
case $INPUT in 
1)
    echo "burger" 
    OPENCR_MODEL=burger
    ;;   
2)
    echo "waffle or waffle-pi" 
    OPENCR_MODEL=waffle
    ;;             
*)
    echo "Default is burger" 
    OPENCR_MODEL=burger
    ;;
esac   
# exit
echo "Download firmware"
if [ -d ~/tools/opencr_update ]; then
    rm -rf ~/tools/opencr_update 
    rm -rf ~/tools/opencr_update.tar.bz2 
fi

if [ ! -d ~/tools ]; then 
    mkdir ~/tools
fi 

cd ~/tools 
wget https://github.com/ROBOTIS-GIT/OpenCR-Binaries/raw/master/turtlebot3/ROS2/latest/opencr_update.tar.bz2

echo "Unzip firmware"
tar -xvf opencr_update.tar.bz2

echo "Flash firmware to opencr"
cd ./opencr_update
sudo chmod 777 /dev/ttyACM0
./update.sh $OPENCR_PORT $OPENCR_MODEL.opencr