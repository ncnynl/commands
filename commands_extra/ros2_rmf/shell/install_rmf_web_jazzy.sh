#!/bin/bash
################################################
# Function : Installing the ROS2 jazzy version of the RMF-WEB from source code
# Desc     : 用于源码方式安装RMF-WEB jazzy版的脚本   
# Website  : https://www.ncnynl.com/archives/202212/5775.html                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2025-08-18 18:22:04                                
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
echo "$(gettext "Installing the ROS2 jazzy version of the RMF-WEB from source code")"

# Install dependencies
sudo apt install python3-venv
pip3 install pipenv

# Download code
cd ~/ros2_rmf_ws/src/
git clone -b jazzy https://github.com/open-rmf/rmf-web.git
sudo curl -fsSL https://get.pnpm.io/install.sh | bash -
pnpm env use --global 20

# Install
cd ~/ros2_rmf_ws/rmf-web
pnpm install