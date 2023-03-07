#!/bin/bash
################################################################
# Function :install i18n                 #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2023-03-07                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################
# How to get support for diff language
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
# sudo locale-gen "en.UTF-8"
# sudo locale-gen "zh_CN.UTF-8"
# sudo locale-gen "zh_TW.UTF-8"
# sudo dpkg-reconfigure locales

#######################################
# Install i18n
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
support_lang=(
zh_CN
zh_TW
en
)
function install_i18n(){
    for lang in ${support_lang[@]} 
    do
        echo $lang
        if [  -d "/usr/share/locale/$lang/LC_MESSAGES/" ]; then 
            if [ -d ~/tools/commands/commands_i18n/$lang ];then
                cd ~/tools/commands/commands_i18n/$lang 
                pwd
                if [ -f ./commands.mo ]; then 
                    sudo cp commands.mo /usr/share/locale/$lang/LC_MESSAGES/
                    echo "add $lang support!"
                fi
            fi 
        fi
    done 
}
install_i18n
echo -e "Install i18n Finished"


