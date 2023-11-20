#!/bin/bash
################################################################
# Function : launch_ffmpeg_stream 
# Desc     : 安装ffmpeg推流脚本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Mon Nov 20 09:11:04 AM CST 2023                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com     
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.                            
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun：创客智造B群:926779095、C群:937347681、D群:562093920                               
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "launch_ffmpeg_stream")"

source ${HOME}/commands/cs_utils_ros.sh

echo "This script is under DEV state !"

# 颜色选择
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
font="\033[0m"


function _rcm_run_() {
    echo "Install related system dependencies"
    sudo apt-get update
    sudo apt-get install -y screen ffmpeg
}


_stream_start_(){
    # 定义推流地址和推流码
    read -p "输入你的推流地址和推流码(rtmp协议):" rtmp

    # 判断用户输入的地址是否合法
    if [[ $rtmp =~ "rtmp://" ]];then
        echo -e "${green} 推流地址输入正确,程序将进行下一步操作. ${font}"
        sleep 2
        else  
        echo -e "${red} 你输入的地址不合法,请重新运行程序并输入! ${font}"
        exit 1
    fi 

    # 定义视频存放目录
    read -p "输入你的视频存放目录 (格式仅支持mp4,并且要绝对路径,例如/home/ubuntu/Videos):" folder

    # 判断是否需要添加水印
    read -p "是否需要为视频添加水印?水印位置默认在右上方,需要较好CPU支持(yes/no):" watermark
    if [ $watermark = "yes" ];then
        read -p "输入你的水印图片存放绝对路径,例如/opt/image/watermark.jpg (格式支持jpg/png/bmp):" image
        echo -e "${yellow} 添加水印完成,程序将开始推流. ${font}"
        # 循环
        while true
        do
            cd $folder
            for video in $(ls *.mp4)
            do
                ffmpeg -re -i "$video" -i "$image" -filter_complex overlay=W-w-5:5 -c:v libx264 -c:a aac -b:a 192k -strict -2 -f flv ${rtmp}
            done
        done
    fi
    if [ $watermark = "no" ]
    then
        echo -e "${yellow} 你选择不添加水印,程序将开始推流. ${font}"
        # 循环
        while true
        do
            cd $folder
            for video in $(ls *.mp4)
            do
                ffmpeg -re -i "$video" -c:v copy -c:a aac -b:a 192k -strict -2 -f flv ${rtmp}
            done
        done
    fi
}

# 停止推流
_stream_stop_(){
    screen -S stream -X quit
    killall ffmpeg
}


function _rcm_usage_() {
    cat << EOF
Usage:
    launch_ffmpeg_stream 

Description:
    安装ffmpeg推流脚本

Option:
    --help|-h:                                         -- using help
    --debug|-x:                                        -- debug mode, for checking how to run
    --edit|-e:                                         -- edit mode, for edit this file
    --delete|-k:                                       -- delete mode, for delete this file
    --start|-s:                                       -- begin to stream
    --stop|-e:                                       -- end to stream

EOF
}

function rcm_execute() {
    local debug=0

    local ARGS=`getopt -o hekxse --long help,edit,delete,debug,start,stop -n 'Error' -- "$@"`
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
            -s|--start)
                _stream_start_ $*
                exit 1
                ;;  
            -e|--stop)
                _stream_stop_ $*
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
    echo "launch_ffmpeg_stream start ..."
    _rcm_run_ $*

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*