#!/bin/bash
################################################################
# Function :Install commands WEB new version source        #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2024-12-06                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################

#######################################
# Install  Package
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function install_package(){
    echo -e "Install commands_web!"
    cd ~/tools/commands/commands_web

    echo -e "Install python3 deps for commands_web"
    sudo apt install python3-venv -y
    python3 -m venv venv
    source venv/bin/activate
    pip install -r requirements.txt  # 或你需要的库

    #install service
    cd ~/tools/commands/commands_web/config
    ./remove_rcm_webapi.sh
    ./install_rcm_webapi.sh
    
    #ln
    sudo ln -s $HOME/tools/commands/commands_web/rcm-web.sh /usr/bin/rcm-web
}
install_package

echo -e "Install commands_web succesfully!"


