#!/bin/bash
################################################################
# Function : Launch waking_app warehouse_world_keepout_zones_initialpose                    
# Desc     : 启动仓库仿真
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
echo "$(gettext "Launch waking_app warehouse_world_keepout_zones_initialpose")"

ros2 topic pub -1 /initialpose geometry_msgs/PoseWithCovarianceStamped '{ header: {stamp: {sec: 0, nanosec: 0}, frame_id: "map"}, pose: { pose: {position: {x: -3.7, y: 9.0, z: 0.0}, orientation: {w: 1.0}}, } }'",