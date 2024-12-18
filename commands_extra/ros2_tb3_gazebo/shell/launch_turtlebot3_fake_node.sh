#!/bin/bash
################################################################
# Function : Launch turtlebot3_fake_node                                   
# Desc     : 启动turtlebot3仿真伪节点
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
echo "$(gettext "Launch turtlebot3_fake_node")"

ros2 launch turtlebot3_fake_node turtlebot3_fake_node.launch.py
