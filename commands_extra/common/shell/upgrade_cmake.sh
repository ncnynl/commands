#!/bin/bash
################################################################
# Function : upgrade_cmake 
# Desc     : 升级cmake到指定版本版本的脚本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Fri Oct 27 09:24:41 AM CST 2023                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com     
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.                            
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun：创客智造B群:926779095、C群:937347681、D群:562093920                               
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "upgrade_cmake")"

source ${HOME}/commands/cs_utils_ros.sh

echo "This script is under DEV state !"

echo "某些软件包编译时需要高版本的Cmake，因此需要升级Cmake"
echo "不能使用 sudo apt-get remove cmake卸载低版本cmake后再重装高版本，这样做会导致之前编译和安装的很多库一起被卸载！！！"
echo "SOURCE: https://cmake.org/files/"

function _rcm_run_() {
    if [ $1 ]; then 
        version=$1
        version_sub=${version%.*}
        package_name="cmake-$version"
        package_name_gz=$package_name".tar.gz"
        url="https://cmake.org/files/v$version_sub/cmake-$version.tar.gz" 
    else
        version="3.22.6"
        version_sub=${version%.*}
        package_name="cmake-$version"
        package_name_gz=$package_name".tar.gz"
        url="https://cmake.org/files/v$version_sub/cmake-$version.tar.gz"
    fi

    echo "version is : $version"
    echo "version_sub is: $version_sub"
    echo "package_name is : $package_name"
    echo "package_name_gz is : $package_name_gz"
    echo "url is : $url"

    # if installed ?
    if [ -d ~/tools/$package_name ]; then
        echo "$package_name have installed!!" 
    else 

        echo "Install related system dependencies"
        sudo apt-get update
        sudo apt-get -y install libssl-dev

        echo "Go to workspace"
        if [ ! -d ~/tools ]; then
            mkdir -p ~/tools/
        fi 
        cd ~/tools/

        # 获取仓库列表
        #run import
        echo "this will take a while to download"
        echo "Dowload $package_name"
        wget $url

        echo "Build the code"
        tar -xvzf $package_name_gz
        cd $package_name
        chmod 777 ./configure
        ./configure   
        make
        sudo make install

        echo "Configure cmake"
        sudo update-alternatives --install /usr/bin/cmake cmake /usr/local/bin/cmake 1 --force

        echo "check new version:"
        cmake --version

    fi
}

function _rcm_usage_() {
    cat << EOF
Usage:
    upgrade_cmake 

Description:
    升级cmake到指定版本版本的脚本

Option:
    --help|-h:                                         -- using help
    --debug|-x:                                        -- debug mode, for checking how to run
    --edit|-e:                                         -- edit mode, for edit this file
    --delete|-k:                                       -- delete mode, for delete this file
    --version|-v：                                     -- select version for install

EOF
}

function rcm_execute() {
    local debug=0

    local ARGS=`getopt -o hekxv: --long help,edit,delete,debug,version: -n 'Error' -- "$@"`
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
            -v|--version)
                version=$2
                shift 2
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
    echo "upgrade_cmake start ..."
    _rcm_run_ $version

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*