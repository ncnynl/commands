#!/bin/bash
################################################
# Function : Install ROS2 depthai-python
# Desc     : 用于源码方式安装ros2 depthai-python驱动的脚本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2024-12-11                          
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
#https://gitee.com/ncnynl/depthai-python-ros2.git


export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install depthai-python-ros2")"

# echo "Not Yet Supported!"
# exit 0   
# workspace       
workspace=tools

#workspace is exits ?
if [ ! -d ~/$workspace ];then 
    mkdir -p ~/$workspace/
fi 

if [ -d ~/$workspace/depthai-python-ros2 ];then 
    echo "depthai-python-ros2 have installed" && exit 0
fi 

# 下载源码
cd ~/$workspace/

#download wheeltec_gps
git clone  https://gitee.com/ncnynl/depthai-python-ros2.git

#build
cd ~/$workspace/depthai-python-ros2
python3 examples/install_requirements.py

#udev 
echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="03e7", MODE="0666"' | sudo tee /etc/udev/rules.d/80-movidius.rules
sudo udevadm control --reload-rules && sudo udevadm trigger


# python3 utilities/cam_test.py -rs -cams left,c right,c 
# python3 utilities/cam_ros.py -rs -cams left,c right,c 