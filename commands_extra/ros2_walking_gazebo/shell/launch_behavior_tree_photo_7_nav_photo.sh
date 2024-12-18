#!/bin/bash
################################################################
# Function : Launch behavior_tree_photo_7_nav_photo                            
# Desc     : 启动任务拍照2, 通过导航到目标点后触发拍照
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
echo "$(gettext "Launch behavior_tree_photo_7_nav_photo")"

ros2 launch walking_bt bt_ros2.launch.py bt_xml:=$HOME/aiwalking_ws/src/walking_bt/bt_xml/bt_nav_mememan_snapshot.xml