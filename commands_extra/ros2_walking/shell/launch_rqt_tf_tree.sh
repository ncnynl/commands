#!/bin/bash
################################################################
# Function : Launch walking_tf_tree                    
# Desc     : 查看walking_tf_tree的脚本
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
echo "$(gettext "Launch walking_tf_tree")"

ros2 run rqt_tf_tree rqt_tf_tree