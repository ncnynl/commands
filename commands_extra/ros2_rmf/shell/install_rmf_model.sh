#!/bin/bash
################################################
# Function : install_ros2_rmf_source_shell.sh                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-07-06 18:22:04                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
#base on 22.09 branch 
# https://github.com/open-rmf/rmf_demos.git
# echo "Not Yet Supported!"

if [ -d ~/.gazebo/models/Caddy ];then 
	echo "rmf model have installed" && exit 0
fi

#copy modele to .model
cp -r ~/ros2_rmf_ws/src/demonstrations/rmf_demos/rmf_demos_assets/models/* ~/.gazebo/models/

echo "rmf model has installed successfully!"