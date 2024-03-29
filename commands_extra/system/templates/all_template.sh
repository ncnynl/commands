#!/bin/bash
################################################################
# Function : script_template related usage
# Desc     : <desc>                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : <date>                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.                            
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun：创客智造B群:926779095、C群:937347681、D群:562093920                       
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "script_template related usage")"

echo "This script is under DEV state !"

function _rcm_usage_() {
    cat << EOF
Usage:
    script_template --along --blong argb --clong argc

Description:
    script_template related usage.

Option:
    --help|-h:                                         -- using help
    --debug|-x:                                        -- debug mode, for checking how to run
    --edit|-e:                                         -- edit mode, for edit this file
    --delete|-k:                                       -- delete mode, for delete this file
    --along|-a:                                        -- boolean option
    --blong|-b:                                        -- option with one parameter
    --clong|-c:                                        -- option with an optional parameter

EOF
}

##########################################################################################################################
#
# English note
# getopt command format description:
#   -o: means define short option
#       Example explanation: `ab:c::` defines three option types.
#           a There is no colon after a, which means that the defined a option is a switch type (true/false), and no additional parameters are required. Using the -a option means true.
#           b Followed by a colon, it means that the defined b option requires additional parameters, such as: `-b 30`
#           c Followed by a double colon, it means that the defined c option has an optional parameter, and the optional parameter must be close to the option, such as: `-carg` instead of `-c arg`
#   -long: means define long options
#       Example explanation: `a-long,b-long:,c-long::`. The meaning is basically the same as above.
#   "$@": a list representing the arguments, not including the command itself
#   -n: indicates information when an error occurs
#   --: A list representing the arguments themselves, not including the command itself
#       How to create a directory with -f
#       `mkdir -f` will fail because -f will be parsed as an option by mkdir
#       `mkdir -- -f` will execute successfully, -f will not be considered as an option
#
##########################################################################################################################
#
# 中文注释
# getopt 命令格式说明:
#   -o: 表示定义短选项
#       示例解释: ab:c:: 定义了三个选项类型。
#           a 后面未带冒号，表示定义的 a 选项是开关类型(true/false)，不需要额外参数，使用 -a 选项即表示true。
#           b 后面带冒号，表示定义的 b 选项需要额外参数，如: -b 30
#           c 后面带双冒号，表示定义的 c 选项有一个可选参数，可选参数必须紧贴选项，如: -carg 而不能是 -c arg
#   -long: 表示定义长选项
#       示例解释: a-long,b-long:,c-long::。含义与上述基本一致。
#   "$@": 表示参数本身的列表，也不包括命令本身
#   -n: 表示出错时的信息
#   --:
#       如何创建一个 -f 的目录
#       mkdir -f 会执行失败，因为 -f 会被 mkdir 当做选项来解析
#       mkdir -- -f 会执行成功，-f 不会被当做选项
#
##########################################################################################################################
function _rcm_edit_(){
    file=${0##*commands/}
    file_path="${HOME}/tools/commands/commands_extra/$file"
    echo "Your file path is : $file_path"
    echo "You are editing this file"
    if [ -f $file_path ]; then 
        vim $file_path
        echo "sync this file"
        rcm system build 
        echo "Done, You have successfully edited, Please run this file again"
    else 
        echo "This file path is : $file_path , but it is not right "
    fi 
    return 
}

function _rcm_delete_(){

    run_file_path=$0
    file=${0##*commands/}
    source_file_path="${HOME}/tools/commands/commands_extra/$file"

    echo "This file have two version: run file and source file"
    echo "Your run file path is : $run_file_path"
    echo "Your source file path is : $source_file_path"
    CHOICE_C=$(echo -e "\n Do you want to delete the run file script? [Y/n]")
    read -p "${CHOICE_C}" YN
    [ -z ${YN} ] && YN = N
    case $YN in 
    [Yy])
        #delete
        if [ -f $run_file_path ]; then 
            rm -rf $run_file_path
            echo "Your run file path is : $run_file_path "
            echo "This file is deleted"
        else
            echo "THis file is not exists!"
        fi
        ;;
    *)
        echo "Your have canceled this operation!"
        return 
        ;;
    esac  

    CHOICE_C=$(echo -e "\n Do you want to delete the source file script? [Y/n]")
    read -p "${CHOICE_C}" YN
    [ -z ${YN} ] && YN = N
    case $YN in 
    [Yy])
        #delete
        if [ -f $source_file_path ]; then 
            rm -rf $source_file_path
            echo "Your source file path is : $source_file_path "
            echo "This file is deleted"
        else
            echo "THis file is not exists!"
        fi    
        ;;
    *)
        echo "Your have canceled this operation!"
        return 
        ;;
    esac  

    return 
}

function rcm_execute() {
    local debug=0

    local ARGS=`getopt -o hekxab:c:: --long help,edit,delete,debug,along,blong:,clong:: -n 'Error' -- "$@"`
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
            -a|--along)
                echo "Option a"
                shift
                ;;
            -b|--blong)
                echo "Option b, argument $2'"
                shift 2
                ;;
            -c|--clong)
                # c has an optional argument. As we are in quoted mode, an empty parameter will be generated if its optional argument is not found.
                case "$2" in
                    "")
                        echo "Option c, no argument"
                        shift 2
                        ;;
                    *)
                        echo "Option c, argument $2'"
                        shift 2
                        ;;
                esac
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
    echo "script_template start ..."

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*