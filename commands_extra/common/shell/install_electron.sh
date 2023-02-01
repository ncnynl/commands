#!/bin/bash
################################################
# Function : install electron
# Desc     : 用于安装electron的脚本                           
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-02-01                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################

if  [ ! -d $HOME/.nvm ]; then 
    echo "Please install nvm first 'cs -s install_nvm' "
else
        
    echo "Install electron"
    npm install --save-dev electron    

    echo "Install electron-packager"
    npm install --save-dev electron-packager

    echo "Init project"
    # Clone this repository
    git clone https://ghproxy.com/https://github.com/electron/electron-quick-start
    # Go into the repository
    cd electron-quick-start
    # Install dependencies
    npm install
    # Run the app
    npm start
    echo "Congratulations, nodejs and yarn have successfully installed"

fi