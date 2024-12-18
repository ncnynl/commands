#!/bin/bash
################################################################
# Function : sync gitee repo                                   #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2023-03-10                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################


function sync_gitee()
{
    echo "Begin to sync gitee "
    git pull origin master 

    echo "Install extra"
    ./install_extra.sh 

    echo "Sync Done!! "
}
sync_gitee