#!/bin/bash
################################################################
# Function : install_coturn 
# Desc     : 安装CoTURN服务器的脚本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Fri Nov  3 02:32:48 PM CST 2023                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com     
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.                            
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun：创客智造B群:926779095、C群:937347681、D群:562093920                               
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "install_coturn")"

source ${HOME}/commands/cs_utils_ros.sh

echo "This script is under DEV state !"

# /usr/bin/turnserver -c /etc/turnserver.conf --pidfile=/var/run/turnserver.pid

function _rcm_run_() {

    package_name="/usr/bin/turnserver"

    # if installed ?
    if [ -f $package_name ]; then
        echo "$package_name have installed!!" 
    else 

        echo "Install related system dependencies"
        sudo apt-get update
        sudo apt-get install -y coturn

        #start the Coturn Daemon at Startup
        sudo sed "s/#TURNSERVER_ENABLED/TURNSERVER_ENABLED/g" -i /etc/default/coturn

        # Add admin user
        sudo turnadmin -a -u testxxx -r xxx.xxx.com -p 123xx

        # Configure Coturn
        sudo systemctl stop coturn 
        sudo cp /etc/turnserver.conf /etc/turnserver.conf.bk

sudo bash -c "cat > /etc/turnserver.conf << EOL
#外部端口
listening-port=3478
#内网IP
listening-ip=172.21.44.xx
#外网IP
external-ip=47.94.213.xx
#使用的端口范围
min-port=49152
max-port=65535
#打开日志
verbose
log-file=/var/log/turn.log
syslog
#长期凭证
lt-cred-mech
#用户和密码
user=testxxx:123xx
#与外网IP对应的域名
realm=xxx.xxx.com
#设定密码随意
cli-password=123xx

EOL"

        ## Start Coturn
        sudo systemctl start coturn 

        # Open ports in firewall
        echo "Open ports in firewall"
        echo "You need 3478/5349 of TCP and UDP"
        # sudo ufw allow 80/tcp
        # sudo ufw allow 443/tcp
        # sudo ufw allow 3478/udp
        # sudo ufw allow 5349/tcp

        # Check status
        sudo systemctl status coturn 

        echo "How to check:"
        echo "https://webrtc.github.io/samples/src/content/peerconnection/trickle-ice/"
        echo "turn:47.94.213.xx:3478"
        echo "stun:47.94.213.xx:3478"
        echo "username: testxxx | password: 123xx "

    fi
}

function _rcm_usage_() {
    cat << EOF
Usage:
    install_coturn 

Description:
    安装CoTURN服务器的脚本

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
    echo "install_coturn start ..."
    _rcm_run_ $*

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*