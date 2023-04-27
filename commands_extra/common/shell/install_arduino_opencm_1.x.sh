#!/bin/bash
################################################
# Function : Install arduino 1.x for opencm 
# Desc     : 用于安装arduino IDE 1.x版本的脚本      
# website  : https://emanual.robotis.com/docs/en/parts/controller/opencm904/                          
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-04-25                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                          
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install arduino 1.x for opencm")"   

echo "Arduono IDE 1.x  for ubuntu 18.04"

echo "Make the OpenCM9.04 USB port be able to upload the Arduino IDE program without root permission"
mkdir ~/tools
cd ~/tools/
wget https://ghproxy.com/https://raw.githubusercontent.com/ROBOTIS-GIT/OpenCM9.04/master/99-opencm-cdc.rules
sudo mv ./99-opencm-cdc.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "Since the OpenCM9.04 libraries is built for 32 bit platform, 64 bit PC needs the 32 bit compiler relevants for the ArduinoIDE"
sudo apt-get install libncurses5-dev:i386

echo "Install the Arduino IDE (Linux)"
echo "Go to https://www.arduino.cc/en/Main/Software download "


wget https://downloads.arduino.cc/arduino-1.8.19-linux64.tar.xz
tar -xf arduino-1.8.19-linux64.tar.xz

echo "Install"
cd ~/tools/arduino-1.8.19

echo "Add to bashrc"
echo 'export PATH=$PATH:$HOME/tools/arduino-1.8.19' >> ~/.bashrc
source ~/.bashrc


echo "How to use: "
echo "1. open arduino"
echo "2. click File → Preferences"
echo "3. copy https://raw.githubusercontent.com/ROBOTIS-GIT/OpenCM9.04/master/arduino/opencm_release/package_opencm9.04_index.json to Additional Boards Manager URLs"
echo "4. Click Tools → Board → Boards Manager. Type OpenCM9.04 into the textbox to find the OpenCM9.04 by ROBOTIS package. After it finds out, click Install."
echo "5. OpenCM9.04 Board is now on the list of Tools → Board. Click this to import the OpenCM9.04 Board source"
echo "6. The OpenCM9.04 should be connected to the PC and the OpenCM9.04 via the USB ports.Select Tools → Port → /dev/ttyACM0."
echo "7. install DYNAMIXEL2Arduino library Sketch->Inlcude library ->Manage libraries -> DYNAMIXEL2Arduino  https://emanual.robotis.com/docs/en/parts/controller/opencm904/."
