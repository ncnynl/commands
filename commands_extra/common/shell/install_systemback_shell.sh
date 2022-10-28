#!/bin/bash
################################################
# Function : install_systemback_shell.sh                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-06-24 15:05:45                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
        

#run repository

# 添加仓库

sudo add-apt-repository "deb http://ppa.launchpad.net/nemh/systemback/ubuntu xenial main"

#run key

# 添加KEY

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 382003C2C8B7B4AB813E915B14E4942973C62A1B

#run update

# 更新软件清单

sudo apt update

#run systemback

# 安装系统备份软件systemback

sudo apt install -y systemback

