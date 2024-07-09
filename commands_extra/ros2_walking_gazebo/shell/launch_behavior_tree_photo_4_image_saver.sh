#!/bin/bash
################################################################
# Function : Launch behavior_tree_photo_4_image_saver                               
# Desc     : 当服务/save收到内容, 则保存ros2_openvino_toolkit/image_rviz图像话题
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com                                    
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch behavior_tree_photo_4_image_saver")"

mkdir ~/snapshot/;cd ~/snapshot/;ros2 run image_view image_saver  --ros-args --param save_all_image:=false --remap image:=ros2_openvino_toolkit/image_rviz 
