#!/bin/bash
################################################################
# Function : Launch behavior_tree_interrupt_3_bt2                                  
# Desc     : 启动walking-gazebo行为树,通过ros2 run方式
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
echo "$(gettext "Launch behavior_tree_interrupt_3_bt2")"

ros2 run walking_bt bt_ros2 --ros-args -p bt_xml:=$HOME/aiwalking_ws/src/walking_bt/bt_xml/bt_nav_mememan_interrupt.xml
