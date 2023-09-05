#!/bin/bash
################################################
# Function : Check echo shell  
# Desc     : 用于生成RCM的脚本目录和脚本                          
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-09-04                             
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

function _rcm_usage_() {
    cat << EOF
Usage:
    create --dir <dir_name> --dirdesc <description>
    create --script <script_name> --scriptdesc <description>

Description:
    用于RCM脚本开发，创建一个子目录或脚本

Option:
    --help|-h:                                          -- using help
    --debug|-x:                                         -- debug mode
    --dir|-d:                                           -- 创建目录，需要提供目录名称
    --dirdesc|-dd:                                      -- 创建目录，需要提供目录描述    
    --script|-s:                                        -- 创建脚本, 需要提供脚本名称
    --scriptdesc|-sd:                                   -- 创建脚本，需要提供脚本的描述

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

function rcm_execute() {
    local debug=0    
    local script_name
    local script_desc
    local dir_name
    local dir_desc

    local ARGS=`getopt --options h,x,d:dd:,s:,sd: --longoptions help,debug,dir:,dirdesc:,script:,scriptdesc: -n 'Error' -- "$@"`
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
                dir_name=$2
                shift 2
                ;;
            -s|--script)
                script_name=$2
                script_name=${script_name%.*}
                shift 2
                ;;
            -dt|--dirdesc)
                dir_desc=$2
                shift 2
                ;;
            -st|--scriptdesc)
                script_desc=$2
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

    
    local current_path=$CS_DEV_SCRIPT

    # echo $dir_name
    # echo $dir_desc
    # echo $script_name
    # echo $script_desc
    # return 
    # 创建目录
    
    if [[ ! -z $dir_name ]]; then
        
        cd $current_path

        working "Current path is under $current_path"

        if [[ -x ${dir_name}.sh ]]; then
            error "There is a shell script named \`${dir_name}\` in current directory. Please use another directory name."
            exit 1
        fi

        if [[ -d ${dir_name} ]]; then
            if [[ -z $script_name ]]; then
                error "There is a sub directory named \`${dir_name}\` in current directory."
                exit 1
            fi
        else
            echo "Building folde: $dir_name in ${current_path}"
            mkdir -p "$dir_name/shell/"

            if [ -d "$dir_name/shell/" ]; then 
                cp system/templates/description_template $dir_name/shell/.description
                if [ -z $dir_desc ]; then 
                    dir_desc="与$dir_name相关脚本目录"
                fi
                echo "$dir_desc" >> $dir_name/shell/.description
                success "This $dir_name is build successfully with the desc $dir_desc!"
            else 
                error "This $dir_name is build failed!"
            fi
        fi
    fi

    # 创建脚本
    
    if [[ ! -z $script_name ]]; then
        cd $current_path

        if [[ -x ${script_name}.sh ]]; then
            error "There is a shell script named \`${script_name}\`. Please use another script name."
            exit 1  
        fi

        if [[ -d $script_name ]]; then
            error "There is a sub directory named \`${script_name}\`. Please use another script name."
            exit 1
        fi

        #if don't have dir_name , use system/shell
        
        if [ -z $dir_name ]; then 
            dir_path="$current_path/system/shell"
        else
            dir_path="$current_path/$dir_name/shell"
        fi

        echo "Building script: $script_name in $dir_path"

        cp system/templates/script_template.sh $dir_path/${script_name}.sh
        sed -i "s/script_template/${script_name}/g" $dir_path/${script_name}.sh
        sed -i "s/<desc>/${script_desc}/g" $dir_path/${script_name}.sh
        sed -i "s/<date>/`date`/g" $dir_path/${script_name}.sh

        if [ -f $dir_path/${script_name}.sh ]; then 
            success "This $script_name is build successfully with the desc $script_desc!"
        else
            error "This $script_name is build failed!"
        fi
    fi

    if [[ $debug == 1 ]]; then
        set +x
    fi

    #sync file to ~/commands/
    rcm system build
}

# Execute current script
rcm_execute $*