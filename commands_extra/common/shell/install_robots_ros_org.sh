#!/bin/bash
################################################
# Function : install robots ros org  
# Desc     : 用于搭建robots.ros.org网站的脚本                                 
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-11-22                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
        
# https://robots.ros.org/contributing/

#####Procedure
# Fork this repository on GitHub
# Checkout your fork.
# Create a new branch with your robot’s name.
# In the repository run python3 add_robot.py and follow the prompts.
# Add the icons and images into the directories as guided by the script. Icons should be 80x80px, Images at least 600px
# Fill in additional details in the generated post.
# Commit the changes with a descriptive commit message.
# Push the branch back to your fork.
# Open a pull request for review.

#install docker if don't exits
if [ ! -f /usr/bin/docker];then 
    pwd=$(pwd)
    . $(pwd)/install_docker.sh
fi

#mkdir workspace if don't exits
if [ ! -d ~/tools ]; then
    sudo mkdir ~/tools/
fi 

#install deps
sudo apt install python3-empy

#download https://github.com/ros-infrastructure/robots.ros.org
if [ ! -d ~/tools/robots.ros.org ]; then
    cd ~/tools/
    git clone https://ghproxy.com/https://github.com/ros-infrastructure/robots.ros.org
fi 

#start
cd ~/tools/robots.ros.org
./test_site.bash


#open http://localhost:3000
x-www-browser http://localhost:3000