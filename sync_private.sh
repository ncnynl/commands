#!/bin/bash
################################################################
# Function :Back up private directories and scripts to a fixed location                
# Platform :All Linux Based Platform       
# desc     :备份私有目录和脚本到固定的位置                    
# Version  :1.0                                                
# Date     :2023-09-09                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://ncnynl.com                                      
################################################################

source ${HOME}/commands/cs_utils.sh

function sync_private()
{
    
    #if exists ? 
    if [ ! -d ~/tools/commands_private ]; then 
        mkdir -p ~/tools/commands_private
    fi

    hint "Begin to sync file to commands_private!!"

    # keep _dir
    rsync -azv ~/tools/commands/commands_extra/_* ~/tools/commands_private/

    # keep dir/_*.sh
    rsync -azv --delete --prune-empty-dirs --include='*/' --include='_*.sh' --exclude='*'  ~/tools/commands/commands_extra/  ~/tools/commands_private/
    
    hint "Done!! Please submit to repo"
}

sync_private $*