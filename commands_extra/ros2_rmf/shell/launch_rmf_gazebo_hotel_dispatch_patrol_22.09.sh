#!/bin/bash
################################################################
# Function : Launch rmf_gazebo_hotel_dispatch_patrol_22.09                                  
# Desc     : 启动hotel gazebo仿真dispatch_patrol任务22.09
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com/archives/202211/5669.html                                     
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch rmf_gazebo_hotel_dispatch_patrol_22.09")"

ros2 run rmf_demos_tasks dispatch_patrol -p restaurant  L3_master_suite -n 1 --use_sim_time
