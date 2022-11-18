#!/bin/bash
################################################
# Function : install_nomachine.sh                              
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

#source check_linux_version.sh
. ./shell/check_linux_version.sh

return 
function get_package_url()
{
    link=""
    if [[ $release == "ubuntu"  && $cpu_release == "amd64" ]] ; then 
        link="https://download.nomachine.com/download/7.10/Linux/nomachine_7.10.1_1_amd64.deb"
    elif [[ $release == "ubuntu"  && $cpu_release == "aarch64"  ]]; then 
        link="https://download.nomachine.com/download/7.10/Linux/nomachine_7.10.1_1_arm64.deb"
    fi
    echo $link
}
link=$(get_package_url)
# echo $version
if [[ ! $link ]]; then
    echo -e "This script can not be run in your system now!" && exit 1
fi

# download 
function dowloand_package()
{
    curl -fSL $link -o /tmp/nomachine.deb  
}
dowloand_package

# install nomachine 
function install_package()
{
    sudo dpkg -i /tmp/nomachine.deb
}
install_package