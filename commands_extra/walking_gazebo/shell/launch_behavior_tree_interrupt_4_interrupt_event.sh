#!/bin/bash
################################################################
# Function : Launch behavior_tree_interrupt_4_interrupt_event                                  
# Desc     : 启动发布终止任务
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
echo "$(gettext "Launch behavior_tree_interrupt_4_interrupt_event")"

ros2 topic pub -1 /interrupt_event std_msgs/msg/String data:'gohome'
