#!/bin/bash
################################################
# Function : Install foxglove  
# Desc     : 用于安装ROS话题浏览工具foxglove-studio的脚本                           
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-06-25 17:12:05                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install foxglove")"

#https://github.com/foxglove/studio
# https://foxglove.dev/docs/studio/connection/ros1

# USAGE:
# # To launch the desktop app (run both scripts concurrently):
# $ yarn desktop:serve        # start webpack
# $ yarn desktop:start        # launch electron

# # To launch the browser app:
# $ yarn web:serve

# # To launch the browser app using a local instance of the backend server:
# $ yarn web:serve:local

# # To launch the storybook:
# $ yarn storybook

# # Advanced usage: running webpack and electron on different computers (or VMs) on the same network
# $ yarn desktop:serve --host 192.168.xxx.yyy         # the address where electron can reach the webpack dev server
# $ yarn dlx electron@13.0.0-beta.13 .webpack # launch the version of electron for the current computer's platform

# # To launch the desktop app using production API endpoints
# $ yarn desktop:serve --env FOXGLOVE_BACKEND=production
# $ yarn desktop:start

# # NOTE: yarn web:serve does not support connecting to the production endpoints

echo "install foxglove/studio"

sudo snap install foxglove-studio

echo "Congratulations, You have successfully installed"











