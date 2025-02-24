#!/bin/bash
################################################################
# Function : Launch waking_app inventory_world_v1                    
# Desc     : 启动仓库存货
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
echo "$(gettext "Launch waking_app inventory_world_v1")"

. /usr/share/gazebo/setup.bash 
ros2 launch walking_application inventory_world_v1.launch.py