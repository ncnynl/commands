#!/bin/bash
################################################
# Function : Update rosdep tsinghua  
# Desc     : 用于更新rodep源的脚本                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-06-24 15:17:32                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Update rosdep tsinghua")"       

sudo apt update 
# install dep

sudo apt install -y \
python3-colcon-common-extensions \
python3-rosdep \
python3-vcstool
#run mkdir

if [ ! -d /etc/ros/rosdep/sources.list.d ];then 
    sudo mkdir -p /etc/ros/rosdep/sources.list.d/
fi 

#run curl
if [ ! -f /etc/ros/rosdep/sources.list.d/20-default.list ];then 

    sudo curl -o /etc/ros/rosdep/sources.list.d/20-default.list https://mirrors.tuna.tsinghua.edu.cn/github-raw/ros/rosdistro/master/rosdep/sources.list.d/20-default.list

else

    if ! grep -Fq "tsinghua" /etc/ros/rosdep/sources.list.d/20-default.list
    then
        sudo curl -o /etc/ros/rosdep/sources.list.d/20-default.list https://mirrors.tuna.tsinghua.edu.cn/github-raw/ros/rosdistro/master/rosdep/sources.list.d/20-default.list
    fi

fi

#run export 

export ROSDISTRO_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/rosdistro/index-v4.yaml

#run bashrc
if ! grep -Fq "index-v4.yaml" ~/.bashrc
then
    echo 'export ROSDISTRO_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/rosdistro/index-v4.yaml' >> ~/.bashrc
fi 

#run rosdep update
sudo rosdep fix-permissions

rosdep update