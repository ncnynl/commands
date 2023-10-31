#!/bin/bash
################################################################
# Function : install_bluetooth 
# Desc     : 安装蓝牙服务的脚本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Thu Oct 26 01:57:02 PM CST 2023                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com     
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.                            
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun：创客智造B群:926779095、C群:937347681、D群:562093920                               
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "install_bluetooth")"

source ${HOME}/commands/cs_utils_ros.sh

echo "This script is under DEV state !"

function _rcm_run_() {

    package_name="ailibot2_app"
    # if installed ?
    if [ -d ~/tools/$package_name ]; then
        echo "$package_name have installed!!" 
    else 

        echo "Install related system dependencies"
        sudo apt-get update
        
        echo "Install bluetooth dev"
        sudo apt-get install -y libbluetooth-dev

        # python3 -m pip install --upgrade pip seteptools wheel
        # pip3 install pybluez
        # install newest version
        # pip3 install pybluez
        cd ~/tools/
        git config --global url."https://ghproxy.com/https://github.com".insteadof https://github.com
        git clone https://github.com/pybluez/pybluez
        cd pybluez
        pip3 install .

        echo "Go to workspace"
        if [ ! -d ~/tools/ailibot2_app ]; then
            mkdir -p ~/tools/ailibot2_app
        fi 

        cd ~/tools/ailibot2_app

        echo "Configure var-run-sdp.path"
        sudo usermod -G bluetooth -a $USER

        # echo "########################################" | sudo tee /etc/systemd/system/var-run-sdp.path
        # echo "/etc/systemd/system/var-run-sdp.path"  | sudo tee -a /etc/systemd/system/var-run-sdp.path
        # echo "########################################"  | sudo tee -a /etc/systemd/system/var-run-sdp.path
        # echo ""  | sudo tee -a /etc/systemd/system/var-run-sdp.path
        # echo "[Unit]"  | sudo tee -a /etc/systemd/system/var-run-sdp.path
        # echo "Descrption=Monitor /var/run/sdp"  | sudo tee -a /etc/systemd/system/var-run-sdp.path
        # echo ""  | sudo tee -a /etc/systemd/system/var-run-sdp.path
        # echo "[Install]"  | sudo tee -a /etc/systemd/system/var-run-sdp.path
        # echo "WantedBy=bluetooth.service"  | sudo tee -a /etc/systemd/system/var-run-sdp.path
        # echo ""  | sudo tee -a /etc/systemd/system/var-run-sdp.path
        # echo "[Path]"  | sudo tee -a /etc/systemd/system/var-run-sdp.path
        # echo "PathExists=/var/run/sdp"  | sudo tee -a /etc/systemd/system/var-run-sdp.path
        # echo "Unit=var-run-sdp.service"  | sudo tee -a /etc/systemd/system/var-run-sdp.path

# to file
# SDPPATH='/etc/systemd/system/var-run-sdp.path'
# cat > ${SDPPATH} <<- EOF
# EOF 

# to var 
sudo cat > /etc/systemd/system/var-run-sdp.path <<_EOF_
########################################
/etc/systemd/system/var-run-sdp.path
########################################

[Unit]
Descrption=Monitor /var/run/sdp

[Install]
WantedBy=bluetooth.service

[Path]
PathExists=/var/run/sdp
Unit=var-run-sdp.service
_EOF_  

        # echo "Configure bluetvar-run-sdp.serviceooth"
        # echo "########################################" | sudo tee  /etc/systemd/system/var-run-sdp.service
        # echo "/etc/systemd/system/var-run-sdp.service:" | sudo tee  -a /etc/systemd/system/var-run-sdp.service
        # echo "########################################" | sudo tee  -a /etc/systemd/system/var-run-sdp.service
        # echo "" | sudo tee  -a /etc/systemd/system/var-run-sdp.service
        # echo "[Unit]" | sudo tee  -a /etc/systemd/system/var-run-sdp.service
        # echo "Description=Set permission of /var/run/sdp" | sudo tee  -a /etc/systemd/system/var-run-sdp.service
        # echo "" | sudo tee -a /etc/systemd/system/var-run-sdp.service
        # echo "[Install]" | sudo tee -a  /etc/systemd/system/var-run-sdp.service
        # echo "RequiredBy=var-run-sdp.path" | sudo tee  -a /etc/systemd/system/var-run-sdp.service
        # echo "" | sudo tee -a  /etc/systemd/system/var-run-sdp.service
        # echo "[Service]" | sudo tee  -a /etc/systemd/system/var-run-sdp.service
        # echo "Type=simple" | sudo tee  -a /etc/systemd/system/var-run-sdp.service
        # echo "ExecStart=/bin/chgrp bluetooth /var/run/sdp" | sudo tee -a /etc/systemd/system/var-run-sdp.service

sudo cat > /etc/systemd/system/var-run-sdp.service <<_EOF_
########################################
/etc/systemd/system/var-run-sdp.service:
########################################

[Unit]
Description=Set permission of /var/run/sdp

[Install]
RequiredBy=var-run-sdp.path

[Service]
Type=simple
ExecStart=/bin/chgrp bluetooth /var/run/sdp
_EOF_


        #/etc/systemd/system/bluetooth.target.wants/bluetooth.service
        # /lib/systemd/system/bluetooth.service
        echo "Configure bluetooth.service"
        if [ -f /etc/systemd/system/bluetooth.target.wants/bluetooth.service ]; then 
            sudo sed  "s/bluetooth\/bluetoothd/bluetooth\/bluetoothd -C/"g -i /etc/systemd/system/bluetooth.target.wants/bluetooth.service
            sudo sed "9 aExecStartPost=\/bin\/chmod 662 \/var\/run\/sdp" -i /etc/systemd/system/bluetooth.target.wants/bluetooth.service
        fi 

        if [ -f /lib/systemd/system/bluetooth.service ]; then 
            sudo sed  "s/bluetooth\/bluetoothd/bluetooth\/bluetoothd -C/"g -i /lib/systemd/system/bluetooth.service
            sudo sed "9 aExecStartPost=\/bin\/chmod 662 \/var\/run\/sdp" -i /lib/systemd/system/bluetooth.service
        fi         

        echo "restart bluetooth"
        sudo systemctl daemon-reload
        sudo systemctl restart bluetooth

        sudo chgrp bluetooth  /var/run/sdp

        sudo systemctl daemon-reload
        sudo systemctl restart bluetooth

        # 获取仓库列表
        echo "this will take a while to download"
        echo "Dowload $package_name"
        wget https://gitee.com/ncnynl/ailibot2_app/raw/master/APK/ailibot2_app.apk
        wget https://gitee.com/ncnynl/ailibot2_app/raw/master/teleop_bluetooth.py

        echo "Please reboot PC"

        echo "After reboot , follow USAGE:"
        echo "1. Install ~/tools/ailibot2_app/ailibot2_app.apk to mobilephone"
        echo "2. Pair bluetooth mobilephone and PC"
        echo "3. run script: python3 ~/tools/ailibot2_app/teleop_bluetooth.py"
    fi
}

function _rcm_usage_() {
    cat << EOF
Usage:
    install_bluetooth 

Description:
    安装蓝牙服务的脚本

Option:
    --help|-h:                                         -- using help
    --debug|-x:                                        -- debug mode, for checking how to run
    --edit|-e:                                         -- edit mode, for edit this file
    --delete|-k:                                       -- delete mode, for delete this file

EOF
}

function rcm_execute() {
    local debug=0

    local ARGS=`getopt -o hekx --long help,edit,delete,debug -n 'Error' -- "$@"`
    if [ $? != 0 ]; then
        echo "Invalid option..." >&2;
        exit 1;
    fi
    # rearrange the order of parameters
    eval set -- "$ARGS"
    # after being processed by getopt, the specific options are dealt with below.
    while true ; do
        case "$1" in
            -h|--help)
                _rcm_usage_
                exit 1
                ;;
            -e|--edit)
                _rcm_edit_ $*
                exit 1
                ;;    
            -k|--delete)
                _rcm_delete_ $*
                exit 1
                ;;                           
            -x|--debug)
                debug=1
                shift
                ;;                
            --)
                shift
                break
                ;;
            *)
                echo "Internal Error!"
                exit 1
                ;;
        esac
    done

    if [[ $debug == 1 ]]; then
        set -x
    fi

    # start
    echo "install_bluetooth start ..."
    _rcm_run_ $*

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*