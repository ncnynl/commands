#!/bin/bash
################################################
# Function : Install ROS_Flutter_Gui_App source version 
# Desc     : 用于源码方式安装ROS_Flutter_Gui_App程序的脚本                           
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-07-02 02:39:30                            
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
echo "$(gettext "Install ROS_Flutter_Gui_App source version")"

echo ""
echo "Set workspace"
workspace=tools

echo ""
echo "Set soft name"
soft_name=ROS_Flutter_Gui_App

echo ""
echo "Workspace if exits ?"
if [ ! -d ~/$workspace ];then 
    mkdir -p ~/$workspace/
fi 

echo ""
echo "Software if installed ?"
if [ -d ~/$workspace/$soft_name ];then 
    echo "$soft_name have installed" && exit 0
fi 

echo ""
echo "Install system deps"
sudo apt-get install ros-${ROS_DISTRO}-rosbridge-suite

# 下载源码
echo ""
echo "Download source"
cd ~/$workspace/
git clone -b ${ROS_DISTRO} https://gitee.com/ncnynl/ROS_Flutter_Gui_App

#usage
# https://github.com/ncnynl/ROS_Flutter_Gui_App
#ros2 launch rosbridge_server rosbridge_websocket_launch.xml
#http://localhost:9090

#web
#cd ros_flutter_gui_app_web
#python -m http.server 8000
#http://localhost:8000