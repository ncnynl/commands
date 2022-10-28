#!/bin/bash
################################################################
# Function :ROS Commands Manager Shell Script                  #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-06-23                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################


function get_files(){
    path=~/tools/commands/commands_extra/commands_lists.json
    for line in `cat ${path}`
    do
        echo $line
    done
}

get_files


