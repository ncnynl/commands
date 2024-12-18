#!/bin/bash
################################################################
# Function : Launch behavior_tree_pipeline_object_4_bt                                  
# Desc     : 启动pipeline_object任务
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
echo "$(gettext "Launch behavior_tree_pipeline_object_4_bt")"

ros2 launch walking_bt bt_ros2.launch.py bt_xml:=$HOME/bt_ros2_ws/src/BT_ros2/bt_xml/bt_openvino.xml
