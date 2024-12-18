#!/bin/bash
################################################
# Function : Install arduino 1.x for opencr 
# Desc     : 用于安装opencr的arduino IDE 1.x版本的脚本      
# website  : https://www.ncnynl.com/archives/201707/1819.html                          
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-04-27                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                          
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install arduino 1.x for opencr")"   

echo "Arduono IDE 1.x  for ubuntu 18.04"

echo "Make the OpenCR USB port be able to upload the Arduino IDE program without root permission"
mkdir ~/tools
cd ~/tools/
wget https://raw.githubusercontent.com/ROBOTIS-GIT/OpenCR/master/99-opencr-cdc.rules
sudo mv ./99-opencr-cdc.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "Since the OpenCR libraries is built for 32 bit platform, 64 bit PC needs the 32 bit compiler relevants for the ArduinoIDE"
sudo apt-get install libncurses5-dev:i386

echo "Install the Arduino IDE (Linux)"
echo "Go to https://www.arduino.cc/en/Main/Software download "


wget https://downloads.arduino.cc/arduino-1.8.19-linux64.tar.xz
tar -xf arduino-1.8.19-linux64.tar.xz

echo "Install"
cd ~/tools/arduino-1.8.19

echo "Configure Additional Boards Manager URLs"
sed -i "s#boardsmanager.additional.urls=.*#boardsmanager.additional.urls=https://gitee.com/ncnynl/commands/raw/master/commands_extra/common/resource/package_opencr_index.json#"g /home/ubuntu/.arduino15/preferences.txt

echo "Add to bashrc"
echo 'export PATH=$PATH:$HOME/tools/arduino-1.8.19' >> ~/.bashrc
source ~/.bashrc

echo "Arduono IDE 1.x have installed successfully, The arduino location is : ~/tools/arduino-1.8.19 "
echo "How to use: "
echo "1. cd ~/tools/arduino-1.8.19  and ./arduino"
echo "2. click File → Preferences"
echo "3. copy https://gitee.com/ncnynl/commands/raw/master/commands_extra/common/resource/package_opencr_index.json to Additional Boards Manager URLs"
echo "4. Click Tools → Board → Boards Manager. Type OpenCR into the textbox to find the OpenCR by ROBOTIS package. After it finds out, click Install."
echo "5. OpenCR Board is now on the list of Tools → Board. Click this to import the OpenCR Board source"
echo "6. The OpenCR should be connected to the PC and the OpenCR via the USB ports.Select Tools → Port → /dev/ttyACM0."
echo "7. install DYNAMIXEL2Arduino library Sketch->Inlcude library ->Manage libraries -> DYNAMIXEL2Arduino"
