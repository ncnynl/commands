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
        
#基于ubuntu22.04 humble版本安装需要指的版本

#downlaod
cd ~/ros2_rmf_ws/
# git clone https://ghproxy.com/https://github.com/open-rmf/rmf-panel-js
git clone https://gitee.com/ncnynl/rmf-panel-js
cd rmf-panel-js
#安装，需要花一定时间安装
cd ~/ros2_rmf_ws/rmf-panel-js
npm install --prefix rmf_panel
npm run build --prefix rmf_panel

# launch
# cd rmf_panel
# python3 -m http.server 3000
# open http://localhost:3000 on browser
