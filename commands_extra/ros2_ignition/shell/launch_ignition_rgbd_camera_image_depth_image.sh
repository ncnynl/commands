#!/bin/bash
################################################################
# Function : Launch ignition rgbd_camera/depth_image topic                           
# Desc     : 查看/rgbd_camera/depth_image话题
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com/archives/202201/4953.html                                  
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch ignition rgbd_camera/depth_image topic")"

ros2 launch ros_ign_gazebo_demos image_bridge.launch.py image_topic:=/rgbd_camera/depth_image
