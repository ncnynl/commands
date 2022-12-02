#!/bin/bash
################################################
# Function : install pnpm                              
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
        
echo "install pnpm "

if  [ -f $HOME/.local/share/pnpm/pnpm ]; then 
    echo "pnpm has installed "
else

    echo "install pnpm"
    sudo apt update && sudo apt install curl
    curl -fsSL https://get.pnpm.io/install.sh | bash -
    pnpm env use --global 18

    echo "Congratulations, pnpm have successfully installed"

fi

