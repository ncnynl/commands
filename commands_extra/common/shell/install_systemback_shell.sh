#!/bin/bash
################################################
# Function : Install systemback shell  
# Desc     : 用于安装系统备份软件systemback的脚本                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-10-29 17:17:58                            
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
echo "$(gettext "Install systemback shell")"         

#run repository

# 添加仓库

sudo sh -c 'echo "deb [arch=amd64] http://mirrors.bwbot.org/ stable main" > /etc/apt/sources.list.d/systemback.list'

#run key

# 添加KEY

sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key 50B2C005A67B264F

#run update

# 更新软件清单

sudo apt update

#run systemback

# 安装系统备份软件systemback

sudo apt-get install systemback

