#!/bin/bash
################################################
# Function : install arduino.sh                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-12-31                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                          
# QQ Qun: 创客智造D群:562093920                               
################################################


#For simple script , you can execute the script like below 
#rm install_simple.sh ; wget https://gitee.com/ncnynl/commands/raw/master/install_simple.sh ; sudo chmod +x ./install_simple.sh; sudo ./install_simple.sh common install_boot_repair
#rm install_boot_repair.sh ; wget https://gitee.com/ncnynl/commands/raw/master/common/shell/install_boot_repair.sh ; sudo chmod +x ./install_boot_repair.sh; sudo ./install_boot_repair.sh 


#######################################
# commands_install
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function commands_install(){
    FILE="$2.sh"
    URL=https://gitee.com/ncnynl/commands/raw/master/$1/shell/$FILE
    url_status=$(curl -s -m 5 -IL $URL|grep 200)
    if [ $url_status == "" ];then
        echo "$URL is OFF"
    else
        rm $FILE ; wget $URL; sudo chmod +x ./$FILE; sudo ./$FILE
    fi

}
commands_install $1 $2 


