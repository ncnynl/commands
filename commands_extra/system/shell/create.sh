#!/bin/bash
################################################
# Function : Check echo shell  
# Desc     : 用于生成RCM的脚本目录和脚本                          
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-06-28 19:14:02                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                          
################################################

source ${HOME}/commands/cs_utils.sh
source ${HOME}/commands/cs_variables.sh

function _usage_() {
    cat << EOF
Usage:
    create --dir <dirname> <description>
    create --script <scriptname> <description>

Description:
    用于 cs 脚本开发，创建一个子目录或脚本

Option:
    --help|-h:                                          -- using help
    --debug|-x:                                         -- debug mode
    --dir|-d:                                           -- 创建目录，需要提供目录名称
    --script|-s:                                        -- 创建脚本, 需要提供脚本名称
    --text|-t:                                          -- 创建目录或脚本，提供目录或脚本的描述

EOF
}

# getopt 命令格式说明:
#   --options: 表示定义短选项
#       示例解释: ab:c:: 定义了三个选项类型。
#           a 后面未带冒号，表示定义的 a 选项是开关类型(true/false)，不需要额外参数，使用 -a 选项即表示true。
#           b 后面带冒号，表示定义的 b 选项需要额外参数，如: -b 30
#           c 后面带双冒号，表示定义的 c 选项有一个可选参数，可选参数必须紧贴选项，如: -carg 而不能是 -c arg
#   --longoptions: 表示定义长选项
#       示例解释: a-long,b-long:,c-long::。含义与上述基本一致。
#   "$@": 表示参数本身的列表，也不包括命令本身
#   -n: 表示出错时的信息
#   --:
#       如何创建一个 -f 的目录
#       mkdir -f 会执行失败，因为 -f 会被 mkdir 当做选项来解析
#       mkdir -- -f 会执行成功，-f 不会被当做选项

function _exec_() {
    local debug=0    
    local scriptName
    local scriptDesc
    local dirName
    local desc

    local ARGS=`getopt --options h,x,d:,s:,t: --longoptions help,debug,dir:,script:,text: -n 'Error' -- "$@"`
    if [ $? != 0 ]; then
        error "Invalid option..." >&2;
        exit 1;
    fi
    # rearrange the order of parameters
    eval set -- "$ARGS"
    # after being processed by getopt, the specific options are dealt with below.
    while true ; do
        case "$1" in
            -h|--help)
                _usage_
                exit 1
                ;;
            -x|--debug)
                debug=1
                shift
                ;;
            -d|--dir)
                dirName=$2
                shift 2
                ;;
            -s|--script)
                scriptName=$2
                scriptName=${scriptName%.*}
                shift 2
                ;;
            -t|--text)
                desc=$2
                shift 2
                ;;
            --)
                shift
                break
                ;;
            *)
                error "Internal Error!"
                exit 1
                ;;
        esac
    done

    if [[ $debug == 1 ]]; then
        set -x
    fi

    
    local currentPath=$CS_DEV_SCRIPT
    echo $dirName
    echo $desc
    echo $scriptName

    # 创建目录
    if [[ ! -z $dirName ]]; then
        cd $currentPath

        working "Current path is under $currentPath"

        if [[ -x ${dirName}.sh ]]; then
            error "There is a shell script named \`${dirName}\` in current directory. Please use another directory name."
            exit 1
        fi

        if [[ -d ${dirname} ]]; then
            error "There is a sub directory named \`${dirName}\` in current directory. Please use another directory name."
            exit 1
        fi

        mkdir -p "$dirName/shell/"

        if [ -d "$dirName/shell/" ]; then 
            cp system/templates/description_template $dirName/shell/.description
            if [ -z $desc ]; then 
                $desc = "$dirName 相关功能"
            fi
            echo "$desc" >> $dirName/shell/.description
            success "Build $dirname success with the desc $desc!"
        else 
            error "Build $dirname failed!"
        fi
    fi

    # 创建脚本
    # if [[ ! -z $scriptName ]]; then
        # if [[ -x ${scriptName}.sh ]]; then
        #     error "There is a shell script named \`${scriptName}\`. Please use another script name."
        #     exit 1  
        # fi

        # if [[ -d $scriptName ]]; then
        #     error "There is a sub directory named \`${scriptName}\`. Please use another script name."
        #     exit 1
        # fi

        # local underline=`echo $scriptName | sed "s/-/_/g"`
        # cp $NOX_ROOT/templates/script-template.sh ${scriptName}.sh
        # sed -i "s/script-template/${scriptName}/g" ${scriptName}.sh
        # sed -i "s/script_template/${underline}/g" ${scriptName}.sh
        # sed -i "s/<ldap>/${ldap}/g" ${scriptName}.sh
        # sed -i "s/<date>/`date`/g" ${scriptName}.sh
    # fi

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
_exec_ $*