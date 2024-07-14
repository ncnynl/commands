#!/bin/bash
#export TEXTDOMAINDIR=/usr/share/locale
#export TEXTDOMAIN=commands
#echo "$(gettext "hello")"

# msgfmt -o test.sh.mo test.sh.zh_CN.po
# sudo mv test.sh.mo /usr/share/locale/zh_CN/LC_MESSAGES/

# msgfmt -o test.sh.mo test.sh.en.po
# sudo cp test.sh.mo /usr/share/locale/en/LC_MESSAGES/
# sudo mv test.sh.mo /usr/share/locale/en/LC_MESSAGES/

# export TEXTDOMAINDIR=/usr/share/locale

# export LANG=zh_CN.UTF-8

# export LANG=

# export LC_ALL="it_IT.UTF-8"

# locale

# sudo locale-gen "en_HK.UTF-8"

# sudo locale-gen "zh_CN.UTF-8"

# sudo dpkg-reconfigure locales

#file_name="/home/ubuntu/commands/ros_easy/shell/load_ros4.sh"
## sed -i -e "/$file_name/d" ./del_string.txt
#echo $file_name
#echo ${file_name##*/}

# function check_installed()
# {
#     is_exits=$(which is $1)
#     if [ ${#is_exits} != 0 ]; then 
#         echo 1
#     else
#         echo 0
#     fi
# }

# echo $(check_installed ros2)

# echo "$(printf '%s' " - 命令格式: rcm dddd dddd [查看代码](#ddddd)")"  > DOCUMENT.md

# version="3.22.6"
# echo $verion
# version_sub=${version%.*}
# echo $version_sub
# package_name="cmake-$version"
# echo $package_name
# package_name_gz=$package_name".tar.gz"
# echo $package_name_gz
# url="https://cmake.org/files/v$version_sub/cmake-$version.tar.gz"
# echo $url


# function is_empty_dir(){ 
#     echo `ls -A $1|wc -w`
# }

# echo $(is_empty_dir $HOME)

# function check_url()
# {
#    filestatus=$(curl -s -m 5 -IL $1|grep 200)
#    if [ ${#filestatus} != 0 ]; then 
#     echo 1
#    else 
#     echo 0
#    fi
# }

# echo $(check_url 'https://www.ncnynl.comd')

# function check_system()
# {
#     echo $(awk -F'[= "]' '/VERSION_ID/{print $3}' /etc/os-release)
# }

# function check_cpu()
# {
#     echo $(uname -m)
# }

# echo $(check_system)
# echo $(check_cpu)


# str="x-ms-request-id: 7dd8cea3-901e-005a-4986-0487b2000000"  
# # str=""  
# echo ${#str} 

# if [ ${#str} != 0  ]; then 
#     echo "a"
# else 
#     echo "b"
# fi 
package_noinstall="sadfdf"

if [ ${package_noinstall} ]; then 
    echo "package $package_noinstall is not installed "
    exit 0
fi