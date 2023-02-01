#!/bin/bash
################################################
# Function : install nvm  
# Desc     : 用于安装nodejs管理工具NVM的脚本                             
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
        
echo "install nvm and nodejs "

#https://github.com/nvm-sh/nvm
if  [ -d $HOME/.nvm ]; then 
    echo "nvm has installed "
else

    echo "install nvm"
    sudo apt update && sudo apt install curl
    curl -o- https://ghproxy.com/https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh  | sed  "s/https:\/\//https:\/\/ghproxy.com\/https:\/\//"g | bash 
    echo "Congratulations, nvm have successfully installed"

fi
