#!/bin/bash
################################################
# Function : Install cv camera
# Desc     : 用于源码方式安装ROS1版本ros opencv相机驱动cv_camera的脚本                         
# Platform : ubuntu                                
# Version  : 1.0                              
# Date     : 2022-11-29                          
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
echo "$(gettext "Install cv camera")"
#        
# echo "Not Yet Supported!"
# exit 0    
# https://github.com/OTL/cv_camera

workspace=ros1_vslam_ws

if [ -d ~/$workspace/cv_camera ]; then
    echo "ros1 cv_camera have installed!!" 
else
    #install deps
    sudo apt-get update

    echo "Download ROS1 ${ROS_DISTRO} cv_camera"
    if [ ! -d ~/$workspace/src ];then
        mkdir -p ~/$workspace/src
    fi

    cd ~/$workspace/src 
    git clone https://github.com/OTL/cv_camera.git
    cd ~/$workspace/ && catkin_make

    #EXAMPLE of use: rosparam set cv_camera/device_id 001
    #EXAMPLE of use: rosrun cv_camera cv_camera_node

    #add to bashrc if not exits
    if ! grep -Fq "$workspace/devel/setup.bash" ~/.bashrc
    then
        echo ". ~/$workspace/devel/setup.bash" >> ~/.bashrc
        echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
    else
        echo "Has been inited before! Please check ~/.bashrc"
    fi    

    echo "ROS ${ROS_DISTRO} cv_camera installed successfully"
fi
