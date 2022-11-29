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
echo "Not Yet Supported!"
exit 0
#基于ubuntu22.04 humble版本安装需要指的版本
#安装nvm和nodejs
# sudo apt update && sudo apt install curl
# curl -o- https://ghproxy.com/https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
# nvm install 16

#设置国内源
# npm config set registry https://registry.npm.taobao.org

#安装pnpm
# curl -fsSL https://get.pnpm.io/install.sh | bash -
# pnpm env use --global 16

#source 
source ~/.bashrc 

#Install dependencies
# sudo apt install python3-venv

#Install PostgreSQL
# sudo apt install postgresql postgresql-contrib -y
# Set a default password
# sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'postgres';"
# sudo systemctl restart postgresql

# interactive prompt
# sudo -i -u postgres
#To manually reset the database:
#sudo -u postgres bash -c "dropdb postgres; createdb postgres"

#downlaod
cd ~/ros2_rmf_ws/
git clone https://ghproxy.com/https://github.com/open-rmf/rmf-web
cd rmf-web
#安装，需要花一定时间安装
cd ~/ros2_rmf_ws/rmf-web
pnpm install

# launch
# cd packages/dashboard
# pnpm start
