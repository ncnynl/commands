#!/bin/bash
################################################################
# Function : Launch rmf_barista_ff_7_path_request_1                                 
# Desc     : 路径请求，请求机器人1执行一串目标命令,请在终端执行
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com/archives/202211/5668.html                                     
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Launch rmf_barista_ff_7_path_request_1")"

ros2 run ff_examples_ros2 send_path_request.py -f barista -r barista_1 -i unique_task_id_200 -p '[{"x": 10.5, "y": -8.78, "yaw": 0.0, "level_name": "B1"}, {"x": 10.2, "y": -9.7, "yaw": 1.57, "level_name": "B1"}, {"x": 9.3, "y": -11.1, "yaw": 3.14, "level_name": "B1"}, {"x": 7.84, "y": -9.05, "yaw": 4.71, "level_name": "B1"}]'"