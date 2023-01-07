#!/bin/bash
################################################
# Function : install ros2 rmf_web 22.04   
# Desc     : 用于源码方式安装RMF-WEB 22.04/humble版的脚本                            
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
# echo "Not Yet Supported!"
# exit 0
#基于ubuntu22.04 humble版本安装需要指的版本
#安装nvm和nodejs
#install nodejs and npm
if [ ! -d /usr/share/nodejs ];then
    sh -c "~/commands/common/shell/install_nvm.sh"
    sh -c "~/commands/common/shell/install_nodejs.sh"
fi


# #设置国内源
# npm config set registry https://registry.npm.taobao.org

# #安装pnpm
if  [ ! -f $HOME/.local/share/pnpm/pnpm ]; then 
    sh -c "~/commands/common/shell/install_pnpm.sh"
fi 


# #Install dependencies
sudo apt install -y python3-venv
sudo apt install -y libpango1.0-dev
python3 -m pip install tortoise

# #Install PostgreSQL
sudo apt install postgresql postgresql-contrib -y
# Set a default password
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'postgres';"
sudo systemctl restart postgresql

# interactive prompt
# sudo -i -u postgres
#To manually reset the database:
# sudo -u postgres bash -c "dropdb postgres; createdb postgres"

#downlaod
#commit dbdfb532b653642bb91ea3ed553c399d60220c0c
cd ~/ros2_rmf_ws/
git clone -b main https://ghproxy.com/https://github.com/open-rmf/rmf-web

#安装，需要花一定时间安装
cd ~/ros2_rmf_ws/rmf-web

# pnpm
export PNPM_HOME="/home/ubuntu/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
pnpm env use --global 18
pnpm install

# launch
# cd packages/dashboard
# export NODE_OPTIONS='--openssl-legacy-provider'
# pnpm start
