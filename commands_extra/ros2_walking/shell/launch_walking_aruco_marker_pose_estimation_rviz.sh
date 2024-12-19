#!/bin/bash
################################################################
# Function : Launch aruco_marker_pose_estimation_rviz                 
# Desc     : 启动aruco_marker_pose_estimation_rviz
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-08                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://ncnynl.com                                      
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch aruco_marker_pose_estimation_rviz")"

ros2 launch walking_visual rviz.launch.py