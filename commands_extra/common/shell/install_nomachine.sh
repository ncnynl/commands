#!/bin/bash
################################################
# Function : Install nomachine  
# Desc     : 用于安装远程桌面软件nomachine的脚本                             
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
echo "$(gettext "Install nomachine")" 

if [ -f /etc/NX ];then 
    echo "nomachine have installed!!" 
else 

    #source check_linux_version.sh
    . ~/commands/common/shell/check_linux_version.sh

    function get_package_url()
    {
        link=""
        if [[ $release == "ubuntu"  && $cpu_release == "amd64" ]] ; then 
            link="https://download.nomachine.com/download/8.16/Linux/nomachine_8.16.1_1_amd64.deb"
        elif [[ $release == "ubuntu"  && $cpu_release == "aarch64"  ]]; then 
            link="https://download.nomachine.com/download/8.16/Arm/nomachine_8.16.1_1_arm64.deb"
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

    echo "Congratulations, You have successfully installed"
fi
