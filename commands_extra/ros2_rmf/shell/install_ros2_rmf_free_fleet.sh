#!/bin/bash
################################################
# Function : install_ros2_rmf_web_22.04.sh                              
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
        
#基于ubuntu20.04
#安装依赖 

sudo apt update && sudo apt install \
  git wget qt5-default \
  python3-rosdep \
  python3-vcstool \
  python3-colcon-common-extensions \
  # maven default-jdk   # Uncomment to install dependencies for message generation


#downlaod
mkdir -p ~/ros2_rmf_free_fleet_ws/src
cd ~/ros2_rmf_free_fleet_ws/src
#commit 4f2c897b206d55905f51222499cde5dd36a4c093
git clone https://ghproxy.com/https://github.com/open-rmf/free_fleet
cd free_fleet
#安装，需要花一定时间安装
cd ~/ros2_rmf_ws/rmf-panel-js
npm install --prefix rmf_panel
npm run build --prefix rmf_panel

# launch
# cd rmf_panel
# python3 -m http.server 3000
# open http://localhost:3000 on browser
