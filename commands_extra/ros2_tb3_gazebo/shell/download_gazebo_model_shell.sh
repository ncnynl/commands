#!/bin/bash
################################################
# Function : Download ROS2 gazebo model shell 
# Desc     : 用于安装ROS2 Gazebo模型的脚本                             
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-07-02 01:45:01                            
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
echo "$(gettext "Download ROS2 gazebo model shell")"

#run cd gazebo

# 进入~/.gazebo目录

cd ~/.gazebo/

#run download gazebo model
echo "This will take 30-40 min to download. size more than 800M "
#  下载gazebo模型

if [ -d ~/.gazebo/models ];then
    git clone https://ghproxy.com/https://github.com/osrf/gazebo_models gmodels
    cp -r gmodels/* models
    rm -rf gmodels
else 
    git clone https://ghproxy.com/https://github.com/osrf/gazebo_models models
    #run rm model git
    echo "rm .git folder"
    # 删除.git目录
    rm -rf models/.git
fi 

echo "Download models finished"
