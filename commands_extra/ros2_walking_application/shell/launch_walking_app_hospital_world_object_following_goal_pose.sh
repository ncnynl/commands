#!/bin/bash
################################################################
# Function : Launch waking_app hospital_world_object_following_goal_pose                    
# Desc     : 启动hospital_world_object_following_goal_pose
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
echo "$(gettext "Launch waking_app hospital_world_object_following_goal_pose")"

. /usr/share/gazebo/setup.bash 
ros2 topic pub -1 /goal_pose  geometry_msgs/PoseStamped '{ header: {stamp: {sec: 0, nanosec: 0}, frame_id: "map"}, pose: {position: {x: 5.0, y: 0.0, z: 0.25}, orientation: {w: 1.0}}} '