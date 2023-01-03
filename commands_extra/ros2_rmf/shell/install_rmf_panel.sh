#!/bin/bash
################################################
# Function : install_rmf_panel.sh                              
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
        
#ubuntu20.04 have tested 
#ubuntu22.04 not yet

#install nodejs and npm
if [ ! -f /usr/share/nodejs ];then
    sh -c "~/commands/common/shell/install_nvm.sh"
    sh -c "~/commands/common/shell/install_nodejs.sh"
fi

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
