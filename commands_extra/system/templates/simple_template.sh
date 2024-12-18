#!/bin/bash
################################################
# Function : script_template 
# Desc     : <desc>                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : <date>                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "script_template")"

echo "This script is under DEV state !"

function rcm_execute() {
    echo "Start here!"
}

# Execute current script
rcm_execute $*