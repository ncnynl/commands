#!/bin/bash
################################################################
# Function : Launch rmf_barista_ff_8_mode_request_pause_1                              
# Desc     : 模式请求,目前只支持暂停和恢复的,请在终端执行,机器人1
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
echo "$(gettext "Launch rmf_barista_ff_8_mode_request_pause_1")"

source ~/.bashrc; ros2 run ff_examples_ros2 send_mode_request.py -f barista -r barista_1 -m pause -i unique_task_id_301