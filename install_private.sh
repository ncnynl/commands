#!/bin/bash
################################################################
# Function :Copy private directories and scripts to commands_extra location                
# Platform :All Linux Based Platform       
# desc     :复制私有目录和脚本到commands_extra目录                    
# Version  :1.0                                                
# Date     :2023-09-09                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://ncnynl.com                                      
################################################################

source ${HOME}/commands/cs_utils.sh

function install_private()
{
    
    #if exists ? 
    if [ -d ~/tools/commands_private ]; then 
        hint "Begin to sync file to commands_extra!!"

        #rsync
        rsync -azv ~/tools/commands_private/* ~/tools/commands/commands_extra/

        #install
        rcm system build
        
        hint "Done!!"
    else
        hint "You don't have the folder: ~/tools/commands_private "
    fi
}

install_private $*