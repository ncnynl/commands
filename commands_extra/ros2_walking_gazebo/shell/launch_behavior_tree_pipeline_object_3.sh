#!/bin/bash
################################################################
# Function : Launch behavior_tree_pipeline_object_3                                
# Desc     : 启动walking-gazebo对象识别
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
echo "$(gettext "Launch behavior_tree_pipeline_object_3")"

ros2 launch walking_openvino pipeline_object.launch.py use_sim_time:=true
