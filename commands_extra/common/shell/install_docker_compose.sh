#!/bin/bash
################################################
# Function : install docker compose  
# Desc     : 用于安装容器启动组docker-compose的脚本                            
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
        
#安装最新版本的docker compose
#下载

sudo curl -L "https://ghproxy.com/https://github.com/docker/compose/releases/download/v2.12.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

#设置权限 
sudo chmod +x /usr/local/bin/docker-compose

#查看版本 
docker-compose --version

