#!/bin/bash
################################################
# Function : Install nodejs 18.2.1 version 
# Desc     : 用于安装nodejs18.2.1版本，yarn和管理器NVM软件的脚本                             
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
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install nodejs 18.2.1 version")" 

if  [ ! -d $HOME/.nvm ]; then 
    echo "Please install nvm first 'cs -s install_nvm' "
else

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


    echo "install nodejs v18.2.1"
    nvm install 18.2.1

    echo "install yarn"
    npm install -g yarn 

    echo "Congratulations, nodejs and yarn have successfully installed"

fi