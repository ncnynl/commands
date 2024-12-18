#!/bin/bash
################################################
# Function : Config ros1 network shell   
# Desc     : 用于配置ROS1主从的脚本，默认localhost                           
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-07-02 22:15:39                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Config ros1 network shell")"

#run echo 

# 

echo "config  localhost"

#run echo 

# 

echo "export ROS_MASTER_URI=http://localhost:11311">> ~/.bashrc

#run echo 

# 

echo "export ROS_HOSTNAME=localhost">> ~/.bashrc

#run echo 

# 

echo "config finished"

