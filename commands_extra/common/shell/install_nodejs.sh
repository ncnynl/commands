#!/bin/bash
################################################
# Function : install nodejs.sh                              
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


echo "install nvm"
sudo apt update && sudo apt install curl
curl -o- https://ghproxy.com/https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

echo "install nodejs v18.2.1"
nvm install 18.2.1

echo "install yarn"
npm install -g yarn 


echo "Congratulations, You have successfully installed"


