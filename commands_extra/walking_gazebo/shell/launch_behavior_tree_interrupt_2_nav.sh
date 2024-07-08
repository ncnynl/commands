#!/bin/bash
################################################################
# Function : Launch behavior_tree_2_nav                                  
# Desc     : 启动walking-gazebo导航
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
echo "$(gettext "Launch behavior_tree_1_nav")"

ros2 launch walking_navigation bringup.launch.py use_slam:=true  use_sim_time:=true
