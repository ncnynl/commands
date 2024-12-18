#!/bin/bash
################################################################
# Function : Launch rmf_barista_ff_7_path_request_2                                 
# Desc     : 路径请求，请求机器人2执行一串目标命令,请在终端执行
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
echo "$(gettext "Launch rmf_barista_ff_7_path_request_2")"

ros2 run ff_examples_ros2 send_path_request.py -f barista -r barista_2 -i 6 -p '[{"x": 10.142500, "y": -7.412360, "yaw": 0.0, "level_name": "B1"}, {"x": 11.502300, "y": -9.180780, "yaw": 0.0, "level_name": "B1"}, {"x": 10.246500, "y": -11.054800, "yaw": 3.14, "level_name": "B1"}]'"