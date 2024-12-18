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
    echo -e "Build venv for commands!"
    cd ~/tools/commands/commands_web

    echo -e "Install python3 deps for commands"
    pip3 install -r requiments.txt 

    #install service
    cd ~/tools/commands/commands_web/config
    ./install_server_webapi.sh
}
install_package()

echo -e "Install package succesfully!"


