#!/bin/bash
################################################
# Function : Install arduino 2.x for opencm 
# Desc     : 用于安装opencm的arduino IDE 2.x版本的脚本      
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
echo "$(gettext "Install arduino 2.x for opencm")"   

echo "Arduono IDE 2.x  for ubuntu 20.04 + "

echo "Make the OpenCM9.04 USB port be able to upload the Arduino IDE program without root permission"
mkdir ~/tools
cd ~/tools/
wget https://raw.githubusercontent.com/ROBOTIS-GIT/OpenCM9.04/master/99-opencm-cdc.rules
sudo mv ./99-opencm-cdc.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "Since the OpenCM9.04 libraries is built for 32 bit platform, 64 bit PC needs the 32 bit compiler relevants for the ArduinoIDE"
sudo apt-get install libncurses5-dev:i386

echo "Install the Arduino IDE (Linux)"
echo "Go to https://www.arduino.cc/en/Main/Software download "


wget https://github.com/arduino/arduino-ide/releases/download/2.1.0/arduino-ide_2.1.0_Linux_64bit.zip
unzip arduino-ide_2.1.0_Linux_64bit.zip

echo "Install"
cd ~/tools/arduino-ide_2.1.0_Linux_64bit
ln -s arduino-ide arduino

echo "Add to bashrc"
echo 'export PATH=$PATH:$HOME/tools/arduino-ide_2.1.0_Linux_64bit' >> ~/.bashrc
source ~/.bashrc

echo "Arduono IDE 2.x have installed successfully, The arduino location is : ~/tools/arduino-ide_2.1.0_Linux_64bit "
echo "How to use: "
echo "1. cd ~/tools/arduino-ide_2.1.0_Linux_64bit  and ./arduino-ide"
echo "2. click File → Preferences"
echo "3. copy https://raw.githubusercontent.com/ROBOTIS-GIT/OpenCM9.04/master/arduino/opencm_release/package_opencm9.04_index.json to Additional Boards Manager URLs"
echo "4. Click Tools → Board → Boards Manager. Type OpenCM9.04 into the textbox to find the OpenCM9.04 by ROBOTIS package. After it finds out, click Install."
echo "5. OpenCM9.04 Board is now on the list of Tools → Board. Click this to import the OpenCM9.04 Board source"
echo "6. The OpenCM9.04 should be connected to the PC and the OpenCM9.04 via the USB ports.Select Tools → Port → /dev/ttyACM0."
echo "7. install DYNAMIXEL2Arduino library Sketch->Inlcude library ->Manage libraries -> DYNAMIXEL2Arduino  https://emanual.robotis.com/docs/en/parts/controller/opencm904/."
