#!/bin/bash
################################################
# Function : config_ros1_network_shell.sh                              
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
        

#run echo 

# 

echo "config  localhost"

#run echo 

# 

echo "export ROS_MASTER_URI=http://localhost:11311">> ~/.bashrc

#run echo 

# 

echo "export ROS_HOSTNAME=192.168.0.101">> ~/.bashrc

#run echo 

# 

echo "config finished"

