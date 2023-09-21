#!/bin/bash
################################################
# Function : create_udev 
# Desc     : 创建设备端口别名                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Tue Sep 12 08:25:50 AM CST 2023                            
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
echo "$(gettext "create_udev")"

source ${HOME}/commands/cs_utils_ros.sh


function _rcm_run_() {

    echo "目前你的设备有:"
    lsusb | grep -v "root" | awk '{ print NR ": " $0; for(i=6;i<=NF;i++)  printf $i " "; print ""}'

    read -p "择你需要建立udev规则的设备，输入对应行的序号:" line

    echo "你选择的是设备:"
    line=`lsusb | grep -v "root" | awk -v line="$line" 'NR == line {print}'`
    echo $line

    read -p "请指定设备的别名（例如usb）: " alias


    echo "正在为你建立别名规则"
    idVendor=`echo $line | awk '{print $6}' | awk -F':' '{print $1}'`
    idProduct=`echo $line| awk '{print $6}' | awk -F':' '{print $2}'`

    
    bus=`echo $line | awk '{print $2}' `
    device=`echo $line | awk '{print $4}' | awk -F':' '{print $1}'`

    # 判断是否usb设备还是acm设备
    is_usb=$(udevadm info --query=all --name=/dev/bus/usb/$bus/$device | grep 'usb' | wc -l)
    is_acm=$(udevadm info --query=all --name=/dev/bus/usb/$bus/$device | grep 'acm' | wc -l) 

    kernel=""

    if [ $is_usb != 0 ]; then 
        echo "This is usb device!"
        kernel="ttyUSB*"
    else
        if [ $is_acm != 0 ]; then
            echo "This is acm device!"
            kernel="ttyACM*"
        fi
    fi

    if [ $kernel == "" ]; then 
        echo "你选择的设备，不能判断是否是USB设备还是ACM设备!"
        exit 1
    fi

    # 构建udev规则字符串
    rule="KERNEL==\"$kernel\", ATTRS{idVendor}==\"$idVendor\", ATTRS{idProduct}==\"$idProduct\", MODE:="0666" SYMLINK+=\"$alias\""
    echo "根据所选择的设备，生成如下的规则文件"
    echo $rule 

    read -p "确认规则无误，请按Y，放弃请按N: " YN
    case $YN in 
        [Yy])
            # 指定规则文件的路径
            rules_file="/etc/udev/rules.d/$alias.rules"

            # 将规则附加到规则文件
            echo "udev规则文件添加到/etc/udev/rules.d/目录下"
            echo "$rule" | sudo tee -a "$rules_file" > /dev/null

            echo "重新加载udev规则"
            sudo udevadm control --reload-rules

            echo "启动udev服务"
            sudo systemctl restart udev

            echo "udev规则已生成并添加到 $rules_file "
            echo "请重新拔插设备即可生效"  
            echo "check udev: ls /dev/$alias"
            ;;
        *)
            echo "Your have canceled this operation!"
            return 
            ;;
    esac  
}

function _rcm_usage_() {
    cat << EOF
Usage:
    create_udev 

Description:
    创建设备端口别名

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
    echo "create_udev start ..."
    _rcm_run_ $*

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*