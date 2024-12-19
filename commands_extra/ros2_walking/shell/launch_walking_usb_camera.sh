#!/bin/bash
################################################################
# Function : Launch usb_camera_node                 
# Desc     : 启动walking USB相机
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
echo "$(gettext "Launch walking usb_camera_node")"

ros2 launch walking_visual usb_camera_node.launch.py